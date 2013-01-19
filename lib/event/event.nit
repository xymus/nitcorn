module event

in "C header" `{
#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>

#include <arpa/inet.h>

/*struct callback_struct {
        struct evconnlistener* listener;
        void* callback;
};
*/
`}

in "C" `{
static void
echo_read_cb(struct bufferevent *bev, void *ctx)
{
        /*
        char buf[1024];
        int n;
        while ((n = evbuffer_remove(input, buf, sizeof(buf-1))) > 0) {
            printf("%d\n", n);
            printf("%s\n", buf);
        }
        */

        int n;
        size_t buf_length = 1024;//evbuffer_get_length(input);
        char* buf = calloc(buf_length, sizeof(char));
        do {
            memset(buf, 0, buf_length);
                n = bufferevent_read(bev, buf, buf_length);
                ConnectionListener_read_callback(ctx, new_String_from_cstring(buf));
        } while(n > 0);
        free(buf);
}

static void
echo_event_cb(struct bufferevent *bev, short events, void *ctx)
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

/*
    struct callback_struct* cb = malloc(sizeof(*cb));
    cb->listener = listener;
    cb->callback = ctx;
    */
        /* We got a new connection! Set up a bufferevent for it. */
        struct event_base *base = evconnlistener_get_base(listener);
        struct bufferevent *bev = bufferevent_socket_new(
                base, fd, BEV_OPT_CLOSE_ON_FREE);

        bufferevent_setcb(bev, echo_read_cb, NULL, echo_event_cb, listener);

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

interface Callback
        fun accept_callback is abstract
        fun error_callback is abstract
end

extern ConnectionListener
special Callback
    new bind_to(base: EventBase, address : String, port : Int) is extern import String::to_cstring, ConnectionListener::read_callback, ConnectionListener::error_callback `{
        struct sockaddr_in sin;
        struct evconnlistener *listener;

        memset(&sin, 0, sizeof(sin));
        sin.sin_family = AF_INET;
        sin.sin_addr.s_addr = htonl(0); //localhost pour l'instant
        sin.sin_port = htons(port);
        listener = evconnlistener_new_bind(base, (evconnlistener_cb)accept_conn_cb, ConnectionListener_read_callback,
                LEV_OPT_CLOSE_ON_FREE|LEV_OPT_REUSEABLE, -1,
                (struct sockaddr*)&sin, sizeof(sin));
        if(!listener) {
            puts("Cannot create listener");
            exit(1);
        }
        evconnlistener_set_error_cb(listener, (evconnlistener_errorcb)ConnectionListener_error_callback);

        return listener;
    `}

    fun base : EventBase is extern `{
        return evconnlistener_get_base(recv);
    `}

    fun read_callback(read : String) do
            print "{read}"
    end

    redef fun error_callback do
        print "Got an error on connection, quitting loop"
        exit_loop
    end

    fun exit_loop is extern import ConnectionListener::base `{
        event_base_loopexit(ConnectionListener_base(recv), NULL);
    `}

end

var e : EventBase = new EventBase.create_base
var listener : ConnectionListener = new ConnectionListener.bind_to(e, "localhost", 12345)
e.dispatch
