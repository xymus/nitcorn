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
void* trans_recv;
trans_recv = UNBOX_EventBase(recv);
EventBase_dispatch___impl( trans_recv );
nitni_local_ref_clean(  );
}
/* out/indirect function for event::ConnectionListener::bind_to */
val_t NEW_ConnectionListener_event___ConnectionListener___bind_to( val_t base, val_t address, val_t port, val_t reactor )
{
void* trans___base;
String trans___address;
Reactor trans___reactor;
void* orig_return;
val_t trans_return;
trans___base = UNBOX_EventBase(base);
trans___address = malloc( sizeof( struct s_String ) );
trans___address->ref.val = NIT_NULL;
trans___address->ref.count = 0;
nitni_local_ref_add( (struct nitni_ref *)trans___address );
trans___address->ref.val = address;
trans___reactor = malloc( sizeof( struct s_Reactor ) );
trans___reactor->ref.val = NIT_NULL;
trans___reactor->ref.count = 0;
nitni_local_ref_add( (struct nitni_ref *)trans___reactor );
trans___reactor->ref.val = reactor;
orig_return = new_ConnectionListener_bind_to___impl( trans___base, trans___address, UNTAG_Int(port), trans___reactor );
trans_return = BOX_ConnectionListener(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for event::ConnectionListener::base */
val_t ConnectionListener_base___out( val_t recv )
{
void* trans_recv;
void* orig_return;
val_t trans_return;
trans_recv = UNBOX_ConnectionListener(recv);
orig_return = ConnectionListener_base___impl( trans_recv );
trans_return = BOX_EventBase(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for event::ConnectionListener::exit_loop */
void ConnectionListener_exit_loop___out( val_t recv )
{
void* trans_recv;
trans_recv = UNBOX_ConnectionListener(recv);
ConnectionListener_exit_loop___impl( trans_recv );
nitni_local_ref_clean(  );
}
/* out/indirect function for event::String::destroy */
void String_destroy___out( val_t recv )
{
String_destroy___impl( NULL );
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
/* friendly for event::Reactor::read */
void event_Reactor_read( Reactor recv, String line )
{
val_t trans_recv;
val_t trans___line;
trans_recv = recv->ref.val;
trans___line = line->ref.val;
CALL_event___Reactor___read( trans_recv )( trans_recv, trans___line );
}
/* friendly for event::ConnectionListener::read_callback */
void event_ConnectionListener_read_callback( void* recv, String line, Reactor r )
{
val_t trans_recv;
val_t trans___line;
val_t trans___r;
trans_recv = BOX_ConnectionListener(recv);
trans___line = line->ref.val;
trans___r = r->ref.val;
CALL_event___ConnectionListener___read_callback( trans_recv )( trans_recv, trans___line, trans___r );
}
/* friendly for event::ConnectionListener::error_callback */
void event_ConnectionListener_error_callback( void* recv )
{
val_t trans_recv;
trans_recv = BOX_ConnectionListener(recv);
CALL_event___ConnectionListener___error_callback( trans_recv )( trans_recv );
}
/* friendly for event::ConnectionListener::base */
void* event_ConnectionListener_base( void* recv )
{
val_t trans_recv;
val_t orig_return;
void* trans_return;
trans_recv = BOX_ConnectionListener(recv);
orig_return = CALL_event___ConnectionListener___base( trans_recv )( trans_recv );
trans_return = UNBOX_EventBase(orig_return);
return trans_return;
}
