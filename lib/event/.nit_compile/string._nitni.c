#include "string._nitni.h"
#include "/home/jp/Projects-ssd/nit/lib/standard/string_nit.h"
/* out/indirect function for string::String::to_f */
val_t String_to_f___out( val_t recv )
{
String trans_recv;
float orig_return;
val_t trans_return;
trans_recv = malloc( sizeof( struct s_String ) );
trans_recv->ref.val = NIT_NULL;
trans_recv->ref.count = 0;
nitni_local_ref_add( (struct nitni_ref *)trans_recv );
trans_recv->ref.val = recv;
orig_return = String_to_f___impl( trans_recv );
trans_return = BOX_Float(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for string::Sys::native_argc */
val_t Sys_native_argc___out( val_t recv )
{
bigint orig_return;
val_t trans_return;
orig_return = kernel_Sys_Sys_native_argc_0( NULL );
trans_return = TAG_Int(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for string::Sys::native_argv */
val_t Sys_native_argv___out( val_t recv, val_t i )
{
bigint trans___i;
char * orig_return;
val_t trans_return;
trans___i = UNTAG_Int(i);
orig_return = kernel_Sys_Sys_native_argv_1( NULL, trans___i );
trans_return = BOX_NativeString(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* friendly for string::String::to_cstring */
char * string_String_to_cstring( String recv )
{
val_t trans_recv;
val_t orig_return;
char * trans_return;
trans_recv = recv->ref.val;
orig_return = CALL_standard___string___String___to_cstring( trans_recv )( trans_recv );
trans_return = UNBOX_NativeString(orig_return);
return trans_return;
}
