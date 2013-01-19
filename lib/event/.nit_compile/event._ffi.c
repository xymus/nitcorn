/*
	Extern implementation of Nit module event
*/
#include "event._ffi.h"

#define BUF_LEN 1024
static void
echo_read_cb(struct bufferevent *bev, void *ctx)
{
        struct evbuffer *input = bufferevent_get_input(bev);
        /*
        char buf[1024];
        int n;
        while ((n = evbuffer_remove(input, buf, sizeof(buf-1))) > 0) {
            printf("%d\n", n);
            printf("%s\n", buf);
        }
        */

        int n;
        char* buf = calloc(BUF_LEN, sizeof(char));
        memset(buf, '\0', BUF_LEN);
        do {
                memset(buf, '\0', BUF_LEN);
                n = evbuffer_remove(input, buf, BUF_LEN);
                printf("got %d bytes on a buffer of %d\n", n, BUF_LEN);
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
void* new_EventBase_create_base___impl(  )
{
#line 77 "event.nit"

                return event_base_new();
        }
void EventBase_dispatch___impl( void* recv )
{
#line 81 "event.nit"

            event_base_dispatch(recv);
        }
void* new_ConnectionListener_bind_to___impl( void* base, String address, bigint port )
{
#line 94 "event.nit"

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
    }
void* ConnectionListener_base___impl( void* recv )
{
#line 114 "event.nit"

        return evconnlistener_get_base(recv);
    }
void ConnectionListener_exit_loop___impl( void* recv )
{
#line 126 "event.nit"

        event_base_loopexit(ConnectionListener_base(recv), NULL);
    }
