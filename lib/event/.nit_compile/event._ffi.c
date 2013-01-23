/*
	Extern implementation of Nit module event
*/
#include "event._ffi.h"

static void
c_read_cb(struct bufferevent *bev, void *ctx)
{
        struct evbuffer *input = bufferevent_get_input(bev);
        char* buf = NULL;
        size_t sz;
        buf = evbuffer_readln(input, &sz, EVBUFFER_EOL_ANY);
        ConnectionListener_read_callback(
            ((struct callback*)ctx)->listener ,
            new_String_from_cstring(buf),
            ((struct callback*)ctx)->reactor
        );
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

    bufferevent_setcb(bev, c_read_cb, NULL, c_event_cb, ctx);

    bufferevent_enable(bev, EV_READ|EV_WRITE);
}
void* new_EventBase_create_base___impl(  )
{
#line 60 "event.nit"

                return event_base_new();
        }
void EventBase_dispatch___impl( void* recv )
{
#line 64 "event.nit"

            event_base_dispatch(recv);
        }
void* new_ConnectionListener_bind_to___impl( void* base, String address, bigint port, Reactor reactor )
{
#line 75 "event.nit"

        struct sockaddr_in sin;
        struct evconnlistener *listener;

        struct callback* cb = malloc(sizeof(*cb));
        //cb->callback = ConnectionListener_read_callback,;
        cb->reactor = reactor;

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

        return listener;
    }
void* ConnectionListener_base___impl( void* recv )
{
#line 99 "event.nit"

        return evconnlistener_get_base(recv);
    }
void ConnectionListener_exit_loop___impl( void* recv )
{
#line 113 "event.nit"

        event_base_loopexit(ConnectionListener_base(recv), NULL);
    }
void String_destroy___impl( String recv )
{
#line 127 "event.nit"

        free(recv);
    }
