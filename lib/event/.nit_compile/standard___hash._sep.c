/* This C file is generated by NIT to compile module standard___hash. */
#include "standard___hash._sep.h"
static const char LOCATE_standard___hash___Object___hash[] = "hash::Object::hash";
val_t standard___hash___Object___hash(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t REGB1;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___hash;
  fra.me.line = 20;
  fra.me.meth = LOCATE_standard___hash___Object___hash;
  fra.me.has_broke = 0;
  fra.me.REG_size = 1;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[0] = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:24 */
  REGB0 = CALL_standard___kernel___Object___object_id(fra.me.REG[0])(fra.me.REG[0]);
  REGB1 = TAG_Int(8);
  /* /home/jp/Projects-ssd/nit/lib/standard/kernel.nit:242 */
  REGB1 = TAG_Int(UNTAG_Int(REGB0)/UNTAG_Int(REGB1));
  /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:24 */
  goto label1;
  label1: while(0);
  stack_frame_head = fra.me.prev;
  return REGB1;
}
static const char LOCATE_standard___hash___Int___hash[] = "hash::Int::(hash::Object::hash)";
val_t standard___hash___Int___hash(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___hash;
  fra.me.line = 28;
  fra.me.meth = LOCATE_standard___hash___Int___hash;
  fra.me.has_broke = 0;
  fra.me.REG_size = 0;
  fra.me.nitni_local_ref_head = NULL;
  REGB0 = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:28 */
  goto label1;
  label1: while(0);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
static const char LOCATE_standard___hash___Char___hash[] = "hash::Char::(hash::Object::hash)";
val_t standard___hash___Char___hash(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___hash;
  fra.me.line = 32;
  fra.me.meth = LOCATE_standard___hash___Char___hash;
  fra.me.has_broke = 0;
  fra.me.REG_size = 0;
  fra.me.nitni_local_ref_head = NULL;
  REGB0 = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/kernel.nit:416 */
  REGB0 = TAG_Int((unsigned char)UNTAG_Char(REGB0));
  /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:32 */
  goto label1;
  label1: while(0);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
static const char LOCATE_standard___hash___Bool___hash[] = "hash::Bool::(hash::Object::hash)";
val_t standard___hash___Bool___hash(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t REGB1;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___hash;
  fra.me.line = 36;
  fra.me.meth = LOCATE_standard___hash___Bool___hash;
  fra.me.has_broke = 0;
  fra.me.REG_size = 0;
  fra.me.nitni_local_ref_head = NULL;
  REGB0 = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:38 */
  if (UNTAG_Bool(REGB0)) {
    /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:39 */
    REGB0 = TAG_Int(1);
    goto label1;
  } else {
    /* /home/jp/Projects-ssd/nit/lib/standard/hash.nit:41 */
    REGB1 = TAG_Int(0);
    REGB0 = REGB1;
    goto label1;
  }
  label1: while(0);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
