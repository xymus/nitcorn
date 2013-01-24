module event

in "C header" `{
#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>

#include <arpa/inet.h>

struct callback {
        struct evconnlistener* listener;
        Reactor reactor;
        struct bufferevent *buffer_event;
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
        //Reactor_read(((struct callback*)ctx)->reactor, new_String_from_cstring(buf));
        //Reactor_test_me(((struct callback*)ctx)->reactor);
        if(ctx != NULL) {
            ConnectionListener_read_callback(
                ((struct callback*)ctx)->listener ,
                new_String_from_cstring(buf),
                ((struct callback*)ctx)->reactor
            );
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
    new bind_to(base: EventBase, address : String, port : Int) is extern import String::to_cstring, ConnectionListener::read_callback, ConnectionListener::error_callback `{
        struct sockaddr_in sin;
        struct evconnlistener *listener;

        //cb->reactor = reactor;
        //Reactor_incr_ref(reactor);

        memset(&sin, 0, sizeof(sin));
        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = INADDR_ANY;//htonl(0); //localhost pour l'instant
        sin.sin_port = htons(port);
        listener = evconnlistener_new_bind(base, (evconnlistener_cb)accept_conn_cb, NULL,
                LEV_OPT_CLOSE_ON_FREE|LEV_OPT_REUSEABLE, -1,
                (struct sockaddr*)&sin, sizeof(sin));
        if(!listener) {
            puts("Cannot create listener");
            exit(1);
        }
        evconnlistener_set_error_cb(listener, (evconnlistener_errorcb)ConnectionListener_error_callback);

        return listener;
    `}

    fun set_reactor(r : Reactor) is extern import Reactor::set_listener `{
        Reactor_incr_ref(r);
        struct callback* cb = malloc(sizeof(*cb));
        cb->reactor = r;
        cb->listener = recv;
        evconnlistener_set_cb(recv, (evconnlistener_cb)accept_conn_cb, cb);
    `}

    fun write_line(line : String) : Int is extern import String::to_cstring `{
        recv->user_data;
        return 0;
    `}

    fun base : EventBase is extern `{
        return evconnlistener_get_base(recv);
    `}

    fun read_callback(line : String, r : Reactor) do 
        r.read(line)
    end

    fun error_callback do
        print "Got an error on connection, quitting loop"
        exit_loop
    end

    fun exit_loop is extern import ConnectionListener::base `{
        event_base_loopexit(ConnectionListener_base(recv), NULL);
    `}

end

class Reactor
    var connection : nullable ConnectionListener = null

    fun read(line : String) is abstract
    fun write(line : String) do
        connection.write_line(line)
    end
    fun set_listener(l: ConnectionListener) is abstract
end


class HttpReactor
special Reactor
    redef fun read(line : String) do
        print line
    end

    redef fun set_listener(l: ConnectionListener) do connection = l end

end

redef class String
    fun destroy is extern `{
        free(recv);
    `}
end

var e : EventBase = new EventBase.create_base
var listener : ConnectionListener = new ConnectionListener.bind_to(e, "localhost", 12345)

var r : Reactor = new HttpReactor
listener.set_reactor(r)

print "running"
e.dispatch
