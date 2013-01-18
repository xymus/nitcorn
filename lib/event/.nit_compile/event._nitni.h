#include <nit_common.h>
#include "event._sep.h"
#ifndef EVENT_NITNI_H
#define EVENT_NITNI_H

#ifndef STRING_TYPE
#define STRING_TYPE
struct s_String{
		struct nitni_ref ref; /* real ref struct, must be first */
};
typedef struct s_String *String;
#define String_incr_ref( x ) nitni_global_ref_incr( (struct nitni_ref*)(x) )
#define String_decr_ref( x ) nitni_global_ref_decr( (struct nitni_ref*)(x) )
#endif
#include <event._ffi.h>

/* out/indirect function for event::EventBase::create_base */
val_t NEW_EventBase_event___EventBase___create_base(  );

/* out/indirect function for event::EventBase::dispatch */
void EventBase_dispatch___out( val_t recv );

/* out/indirect function for event::ConnectionListener::bind_to */
val_t NEW_ConnectionListener_event___ConnectionListener___bind_to( val_t base, val_t address, val_t port );

/* out/indirect function for event::ConnectionListener::base */
val_t ConnectionListener_base___out( val_t recv );

/* out/indirect function for event::ConnectionListener::exit_loop */
void ConnectionListener_exit_loop___out( val_t recv );
/* friendly for string::String::to_cstring */
char * event_String_to_cstring( String recv );
#ifndef String_to_cstring
#define String_to_cstring event_String_to_cstring
#endif
/* friendly for event::ConnectionListener::read_callback */
void event_ConnectionListener_read_callback( void* recv );
#ifndef ConnectionListener_read_callback
#define ConnectionListener_read_callback event_ConnectionListener_read_callback
#endif
/* friendly for event::ConnectionListener::(event::Callback::error_callback) */
void event_ConnectionListener_error_callback( void* recv );
#ifndef ConnectionListener_error_callback
#define ConnectionListener_error_callback event_ConnectionListener_error_callback
#endif
/* friendly for event::ConnectionListener::base */
void* event_ConnectionListener_base( void* recv );
#ifndef ConnectionListener_base
#define ConnectionListener_base event_ConnectionListener_base
#endif
#endif
