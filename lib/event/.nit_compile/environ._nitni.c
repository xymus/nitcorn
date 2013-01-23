#include "environ._nitni.h"
#include "/home/jp/Projects-ssd/nit/lib/standard/environ_nit.h"
/* out/indirect function for environ::NativeString::get_environ */
val_t NativeString_get_environ___out( val_t recv )
{
char * trans_recv;
char * orig_return;
val_t trans_return;
trans_recv = UNBOX_NativeString(recv);
orig_return = string_NativeString_NativeString_get_environ_0( trans_recv );
trans_return = BOX_NativeString(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
