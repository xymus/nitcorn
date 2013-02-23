module event

in "C header" `{
#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>
#include <errno.h>

#include <arpa/inet.h>

struct callback {
        struct evconnlistener* listener;
        Factory factory;
};

struct connection_listener {
    struct evconnlistener* listener;
    struct callback* cb;
};

struct connection_data {
    Server server;
    struct bufferevent *buffer_event;
    unsigned short close;
};

`}

in "C" `{

static void
c_write_cb(struct bufferevent *bev, void *ctx) {
    if(((struct connection_data*)ctx)->close == 1) {
        Connection_close((struct connection_data*)ctx);
    }
}

static void
c_read_cb(struct bufferevent *bev, void *ctx)
{
    struct evbuffer *input = bufferevent_get_input(bev);
    char* buf = NULL;
    size_t sz;
    buf = evbuffer_readln(input, &sz, EVBUFFER_EOL_ANY);
    //todo
    if(sz > 0) {
        String buf_str = new_String_from_cstring(buf);
        if(ctx != NULL) {
            Connection_read_callback(
                ((struct connection_data*)ctx) ,
                buf_str,
                ((struct connection_data*)ctx)->server
            );
        }
        free(buf);
    }
    if(((struct connection_data*)ctx)->close == 1) {
        Connection_close((struct connection_data*)ctx);
    }
}

static void
c_event_cb(struct bufferevent *bev, short events, void *ctx)
{
        if (events & BEV_EVENT_ERROR)
                perror("Error from bufferevent");
        if (events & (BEV_EVENT_EOF | BEV_EVENT_ERROR)) {
                bufferevent_free(bev);
                free(ctx);
        }
}

static void
accept_conn_cb(struct evconnlistener *listener,
    evutil_socket_t fd, struct sockaddr *address, int socklen,
    void *ctx)
{

    if(ctx == NULL) {
        perror("Cannot accept a listener without a factory");
    }
    struct event_base *base = evconnlistener_get_base(listener);
    struct bufferevent *bev = bufferevent_socket_new(
            base, fd, BEV_OPT_CLOSE_ON_FREE);

    ((struct callback*)ctx)->listener = listener;

    struct connection_data* con = new_Connection_from_server();
    con->buffer_event = bev;

    con->server = Factory_make_server(((struct callback*)ctx)->factory, con);
    Server_incr_ref(con->server);

    bufferevent_setcb(bev, c_read_cb, c_write_cb, c_event_cb, con);
    bufferevent_enable(bev, EV_READ|EV_WRITE);
}
`}

extern Connection
    new from_server is extern `{
        struct connection_data* con = malloc(sizeof(*con));
        con->close = 0;
        return con;
    `}

    fun write_line(line : String) : Int is extern import String::to_cstring `{
        char* c_line = String_to_cstring(line);
        return bufferevent_write(((struct connection_data*)recv)->buffer_event, c_line, strlen(c_line));
    `}

    fun close is extern `{
        /*
         * Check if we have anything left in our buffers. If so, we set our connection to be closed
         * on a callback. Otherwise we close it and free it right away.
         */
        struct evbuffer* out = bufferevent_get_output(((struct connection_data*)recv)->buffer_event);
        struct evbuffer* in = bufferevent_get_input(((struct connection_data*)recv)->buffer_event);
        if(evbuffer_get_length(in) > 0 || evbuffer_get_length(out) > 0) {
            ((struct connection_data*)recv)->close = 1;
        } else {
            bufferevent_free(((struct connection_data*)recv)->buffer_event);
        }
    `}


    private fun read_callback(line : String, r : Server) do 
        r.read(line)
    end

end

extern EventBase
        new create_base is extern `{
            return event_base_new();
        `}

        fun dispatch is extern `{
            event_base_dispatch(recv);
        `}

end
extern ConnectionListener
    new bind_to(base: EventBase, address : String, port : Int, fact: Factory) is extern import Connection::close, Connection::from_server, Factory::set_listener, Factory::make_server, String::to_cstring, Connection::read_callback, ConnectionListener::error_callback `{
        struct sockaddr_in sin;
        struct evconnlistener *listener;
        Factory_incr_ref(fact);

        struct callback* cb = malloc(sizeof(*cb));
        struct connection_listener* con_listener = malloc(sizeof(*con_listener));

        //cb->server = server;
        //Server_incr_ref(server);

        memset(&sin, 0, sizeof(sin));
        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = INADDR_ANY;//htonl(0); //localhost pour l'instant
        sin.sin_port = htons(port);
        listener = evconnlistener_new_bind(base, (evconnlistener_cb)accept_conn_cb, cb,
                LEV_OPT_CLOSE_ON_FREE|LEV_OPT_REUSEABLE, -1,
                (struct sockaddr*)&sin, sizeof(sin));
        if(!listener) {
            puts("Cannot create listener");
            exit(1);
        }
        evconnlistener_set_error_cb(listener, (evconnlistener_errorcb)ConnectionListener_error_callback);

        con_listener->listener = listener;
        Factory_set_listener(fact, listener);

        con_listener->cb = cb;
        cb->listener = listener;
        cb->factory = fact;

        return listener;
    `}

    #fun set_factory(f : Factory) is extern import Server::set_listener, Factory::make_server `{
    #    Factory_incr_ref(f);
    #    struct callback* cb = malloc(sizeof(*cb));
    #    cb->factory = f;
    #    cb->listener = ((struct listener*)recv)->listener;
    #    evconnlistener_set_cb(((struct listener*)recv)->listener, (evconnlistener_cb)accept_conn_cb, cb);
    #    ((struct listener*)recv)->cb = cb;
    #`}
    fun base : EventBase is extern `{
        return evconnlistener_get_base(((struct connection_listener*)recv)->listener);
    `}

    fun error_callback do
        get_socket_error
        print "Quitting loop"
        exit_loop
    end

    fun get_socket_error is extern `{
        int err = EVUTIL_SOCKET_ERROR();
        fprintf(stderr, "Got an error %d (%s) on the listener. ",
            err, evutil_socket_error_to_string(err));
    `}

    fun exit_loop is extern import ConnectionListener::base `{
        event_base_loopexit(ConnectionListener_base(recv), NULL);
    `}

end

class Factory
    var listener : nullable ConnectionListener
    init do end
    fun make_server(c: Connection) : Server is abstract
    fun set_listener(c: ConnectionListener) do self.listener = c
end

class Server
    private var factory : Factory
    private var connection : Connection

    init(f : Factory, c: Connection) do 
        self.factory = f
        self.connection = c
    end

    fun read(line : String) is abstract
    fun write(line : String) do
        self.connection.write_line(line)
    end

    fun close do self.connection.close
end

