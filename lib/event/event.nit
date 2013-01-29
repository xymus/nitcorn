module event

in "C header" `{
#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>

#include <arpa/inet.h>

struct callback {
        struct evconnlistener* listener;
        Server server;
        Factory factory;
        struct bufferevent *buffer_event;
};

struct connection {
    struct evconnlistener* listener;
    struct callback* cb;
};

`}

in "C" `{
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
            ConnectionListener_read_callback(
                ((struct callback*)ctx)->listener ,
                buf_str,
                ((struct callback*)ctx)->server
            );
        }
        free(buf);
    }
}

static void
c_event_cb(struct bufferevent *bev, short events, void *ctx)
{
        if (events & BEV_EVENT_ERROR)
                perror("Error from bufferevent");
        if (events & (BEV_EVENT_EOF | BEV_EVENT_ERROR)) {
                bufferevent_free(bev);
        }
}

static void
accept_conn_cb(struct evconnlistener *listener,
    evutil_socket_t fd, struct sockaddr *address, int socklen,
    void *ctx)
{

    if(ctx == NULL) {
        perror("Cannot accept a connection without a factory");
    }
    struct event_base *base = evconnlistener_get_base(listener);
    struct bufferevent *bev = bufferevent_socket_new(
            base, fd, BEV_OPT_CLOSE_ON_FREE);

    ((struct callback*)ctx)->listener = listener;
    ((struct callback*)ctx)->buffer_event = bev;
    ((struct callback*)ctx)->server = Factory_make_server(((struct callback*)ctx)->factory);
    Server_incr_ref(((struct callback*)ctx)->server);

    bufferevent_setcb(bev, c_read_cb, NULL, c_event_cb, ctx);
    bufferevent_enable(bev, EV_READ|EV_WRITE);
}
`}

extern EventBase
        new create_base is extern `{
            return event_base_new();
        `}

        fun dispatch is extern `{
            event_base_dispatch(recv);
        `}

end
extern ConnectionListener
    new bind_to(base: EventBase, address : String, port : Int, fact: Factory) is extern import Factory::set_listener, Factory::make_server, String::to_cstring, ConnectionListener::read_callback, ConnectionListener::error_callback `{
        struct sockaddr_in sin;
        struct evconnlistener *listener;
        Factory_incr_ref(fact);

        struct callback* cb = malloc(sizeof(*cb));
        struct connection* connection = malloc(sizeof(*connection));

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

        connection->listener = listener;
        Factory_set_listener(fact, connection);

        connection->cb = cb;
        cb->listener = listener;
        cb->factory = fact;

        return connection;
    `}

    #fun set_factory(f : Factory) is extern import Server::set_listener, Factory::make_server `{
    #    Factory_incr_ref(f);
    #    struct callback* cb = malloc(sizeof(*cb));
    #    cb->factory = f;
    #    cb->listener = ((struct connection*)recv)->listener;
    #    evconnlistener_set_cb(((struct connection*)recv)->listener, (evconnlistener_cb)accept_conn_cb, cb);
    #    ((struct connection*)recv)->cb = cb;
    #`}

    fun write_line(line : String) : Int is extern import String::to_cstring `{
        char* c_line = String_to_cstring(line);
        return bufferevent_write(((struct connection*)recv)->cb->buffer_event, c_line, strlen(c_line));
    `}

    fun base : EventBase is extern `{
        return evconnlistener_get_base(((struct connection*)recv)->listener);
    `}

    fun read_callback(line : String, r : Server) do 
        r.read(line)
    end

    fun error_callback do
        print "Got an error on connection, quitting loop"
        exit_loop
    end

    fun exit_loop is extern import ConnectionListener::base `{
        event_base_loopexit(ConnectionListener_base(recv), NULL);
    `}

    fun close is extern `{
        if(((struct connection*)recv)->cb != NULL) {
            bufferevent_free(((struct connection*)recv)->cb->buffer_event);
        }
    `}


end

class Factory
    var connection : nullable ConnectionListener
    init do end
    fun make_server : Server is abstract
    fun set_listener(c: ConnectionListener) do self.connection = c
    fun close do 
        var c = self.connection
        if c != null then c.close
    end
end

class Server
    private var factory : Factory

    init(f : Factory) do self.factory = f

    fun read(line : String) is abstract
    fun write(line : String) do
        self.factory.connection.write_line(line)
    end

    fun close do self.factory.close
end

