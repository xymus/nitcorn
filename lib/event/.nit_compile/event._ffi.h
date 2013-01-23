/*
	Extern implementation of Nit module event
*/
#include <event._nitni.h>

#ifndef EVENT_NIT_H
#define EVENT_NIT_H


#include <event2/listener.h>
#include <event2/bufferevent.h>
#include <event2/buffer.h>

#include <arpa/inet.h>

struct callback {
        struct evconnlistener* listener;
        Reactor reactor;
};
void* new_EventBase_create_base___impl(  );
void EventBase_dispatch___impl( void* recv );
void* new_ConnectionListener_bind_to___impl( void* base, String address, bigint port, Reactor reactor );
void* ConnectionListener_base___impl( void* recv );
void ConnectionListener_exit_loop___impl( void* recv );
void String_destroy___impl( String recv );
#endif
