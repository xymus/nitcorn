module event

in "C header" `{
#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>

#include <arpa/inet.h>

struct callback {
    struct evconnlistener* listener;
    Reactor reactor;
    ReactorFactory reactor_factory;
    struct bufferevent *buffer_event;
    int test;
};

struct nit_listener {
    struct evconnlistener* listener;
    struct callback* cb;
    int abc;
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
                ((struct callback*)ctx)->reactor
            );
            free(buf);
        }
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

    struct event_base *base = evconnlistener_get_base(listener);
    struct bufferevent *bev = bufferevent_socket_new(
            base, fd, BEV_OPT_CLOSE_ON_FREE);

    ((struct callback*)ctx)->listener = listener;
    ((struct callback*)ctx)->buffer_event = bev;
    ((struct callback*)ctx)->reactor = ReactorFactory_make_reactor(((struct callback*)ctx)->reactor_factory);

    Reactor_set_listener(((struct callback*)ctx)->reactor, listener);
    Reactor_incr_ref(((struct callback*)ctx)->reactor);

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
    new bind_to(base: EventBase, address : String, port : Int) is extern import String::to_cstring, ConnectionListener::read_callback, ConnectionListener::error_callback, Reactor::set_listener `{
        struct sockaddr_in sin;

        struct callback* cb = malloc(sizeof(*cb));
        struct nit_listener* nit_listener = malloc(sizeof(*nit_listener));
        cb->reactor_factory = NULL;
        cb->reactor = NULL;
        cb->buffer_event = NULL;

        nit_listener->cb = cb;

        memset(&sin, 0, sizeof(sin));
        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = INADDR_ANY;//htonl(0); //localhost pour l'instant
        sin.sin_port = htons(port);
        nit_listener->listener = evconnlistener_new_bind(base, (evconnlistener_cb)accept_conn_cb, nit_listener->cb,
                LEV_OPT_CLOSE_ON_FREE|LEV_OPT_REUSEABLE, -1,
                (struct sockaddr*)&sin, sizeof(sin));
        if(!nit_listener->listener) {
            puts("Cannot create listener");
            exit(1);
        }
        evconnlistener_set_error_cb(nit_listener->listener, (evconnlistener_errorcb)ConnectionListener_error_callback);

        return nit_listener;
    `}

    fun set_reactor_factory(r : ReactorFactory) is extern import Reactor::set_listener, ReactorFactory::make_reactor `{
       ReactorFactory_incr_ref(r);
       ((struct nit_listener*)recv)->cb->reactor_factory = r;
    `}

    fun write_line(line : String) : Int is extern import String::to_cstring `{
        char* c_line = String_to_cstring(line);
        struct nit_listener* n = ((struct nit_listener*)recv);
        struct callback *cb = ((struct nit_listener*)recv)->cb;
        return bufferevent_write(((struct nit_listener*)recv)->cb->buffer_event, c_line, strlen(c_line));
    `}

    fun base : EventBase is extern `{
        return evconnlistener_get_base(((struct nit_listener*)recv)->listener);
    `}

    fun read_callback(line : String, r : Reactor) do 
        r.read(line)
    end

    fun close is extern `{
        //TODO check if connection does not exist
        if(((struct nit_listener*)recv)->cb != NULL) {
            bufferevent_free(((struct nit_listener*)recv)->cb->buffer_event);
        }
    `}

    fun error_callback do
        print "Got an error on connection, quitting loop"
        exit_loop
    end

    fun exit_loop is extern import ConnectionListener::base `{
        event_base_loopexit(ConnectionListener_base(((struct nit_listener*)recv)->listener), NULL);
    `}

end

class ReactorFactory
    fun make_reactor : Reactor is abstract
end

class Reactor
    private var connection : nullable ConnectionListener = null

    fun read(line : String) is abstract
    fun write(line : String) do
        if connection != null then
            connection.write_line(line)
        end
    end
    fun set_listener(l: ConnectionListener) do 
        print "setting listener"
        connection = l
    end
    fun close do
        self.connection.close
        self.connection = null
    end
end
