#include "time._nitni.h"
#include "/home/jp/Projects-ssd/nit/lib/standard/time_nit.h"
/* out/indirect function for time::Object::get_time */
val_t Object_get_time___out( val_t recv )
{
bigint orig_return;
val_t trans_return;
orig_return = kernel_Any_Any_get_time_0( NULL );
trans_return = TAG_Int(orig_return);
nitni_local_ref_clean(  );
return trans_return;
}
/* out/indirect function for time::Int::sleep */
void Int_sleep___out( val_t recv )
{
bigint trans_recv;
trans_recv = UNTAG_Int(recv);
Int_sleep___impl( trans_recv );
nitni_local_ref_clean(  );
}
/* out/indirect function for time::Int::nanosleep */
void Int_nanosleep___out( val_t recv )
{
bigint trans_recv;
trans_recv = UNTAG_Int(recv);
Int_nanosleep___impl( trans_recv );
nitni_local_ref_clean(  );
}
