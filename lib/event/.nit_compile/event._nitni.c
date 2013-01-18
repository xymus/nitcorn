#include "event._nitni.h"
/* out/indirect function for event::EventBase::create_base */
val_t NEW_EventBase_event___EventBase___create_base(  )
{
void* orig_return;
val_t trans_return;
orig_return = new_EventBase_create_base___impl(  );
trans_return = BOX_EventBase(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for event::EventBase::dispatch */
void EventBase_dispatch___out( val_t recv )
{
EventBase_dispatch___impl( UNBOX_EventBase(recv) );
nitni_local_ref_clean(  );
}
/* out/indirect function for event::ConnectionListener::bind_to */
val_t NEW_ConnectionListener_event___ConnectionListener___bind_to( val_t base, val_t address, val_t port )
{
String trans___address;
bigint trans___port;
void* orig_return;
val_t trans_return;
trans___address = malloc( sizeof( struct s_String ) );
trans___address->ref.val = NIT_NULL;
trans___address->ref.count = 0;
nitni_local_ref_add( (struct nitni_ref *)trans___address );
trans___address->ref.val = address;
trans___port = UNTAG_Int(port);
orig_return = new_ConnectionListener_bind_to___impl( UNBOX_EventBase(base), trans___address, trans___port );
trans_return = BOX_ConnectionListener(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for event::ConnectionListener::base */
val_t ConnectionListener_base___out( val_t recv )
{
void* orig_return;
val_t trans_return;
orig_return = ConnectionListener_base___impl( UNBOX_ConnectionListener(recv) );
trans_return = BOX_EventBase(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for event::ConnectionListener::exit_loop */
void ConnectionListener_exit_loop___out( val_t recv )
{
ConnectionListener_exit_loop___impl( UNBOX_ConnectionListener(recv) );
nitni_local_ref_clean(  );
}
/* friendly for string::String::to_cstring */
char * event_String_to_cstring( String recv )
{
val_t trans_recv;
val_t orig_return;
char * trans_return;
trans_recv = recv->ref.val;
orig_return = CALL_standard___string___String___to_cstring( trans_recv )( trans_recv );
trans_return = UNBOX_NativeString(orig_return);
return trans_return;
}
/* friendly for event::ConnectionListener::read_callback */
void event_ConnectionListener_read_callback( void* recv )
{
CALL_event___ConnectionListener___read_callback( BOX_ConnectionListener(recv) )( BOX_ConnectionListener(recv) );
}
/* friendly for event::ConnectionListener::(event::Callback::error_callback) */
void event_ConnectionListener_error_callback( void* recv )
{
CALL_event___Callback___error_callback( BOX_ConnectionListener(recv) )( BOX_ConnectionListener(recv) );
}
/* friendly for event::ConnectionListener::base */
void* event_ConnectionListener_base( void* recv )
{
val_t orig_return;
void* trans_return;
orig_return = CALL_event___ConnectionListener___base( BOX_ConnectionListener(recv) )( BOX_ConnectionListener(recv) );
trans_return = UNBOX_EventBase(orig_return);
return trans_return;
}
