/* This C file is generated by NIT to compile module standard___time. */
#include "standard___time._sep.h"
static const char LOCATE_standard___time___Object___get_time[] = "time::Object::get_time";
val_t standard___time___Object___get_time(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___time;
  fra.me.line = 20;
  fra.me.meth = LOCATE_standard___time___Object___get_time;
  fra.me.has_broke = 0;
  fra.me.REG_size = 1;
  fra.me.nitni_local_ref_head = NULL;
  fra.me.REG[0] = NIT_NULL;
  fra.me.REG[0] = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/time.nit:20 */
  REGB0 = Object_get_time___out(fra.me.REG[0]);
  stack_frame_head = fra.me.prev;
  return REGB0;
}
static const char LOCATE_standard___time___Int___sleep[] = "time::Int::sleep";
void standard___time___Int___sleep(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___time;
  fra.me.line = 25;
  fra.me.meth = LOCATE_standard___time___Int___sleep;
  fra.me.has_broke = 0;
  fra.me.REG_size = 0;
  fra.me.nitni_local_ref_head = NULL;
  REGB0 = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/time.nit:25 */
  Int_sleep___out(REGB0);
  stack_frame_head = fra.me.prev;
  return;
}
static const char LOCATE_standard___time___Int___nanosleep[] = "time::Int::nanosleep";
void standard___time___Int___nanosleep(val_t p0){
  struct {struct stack_frame_t me;} fra;
  val_t REGB0;
  val_t tmp;
  fra.me.prev = stack_frame_head; stack_frame_head = &fra.me;
  fra.me.file = LOCATE_standard___time;
  fra.me.line = 28;
  fra.me.meth = LOCATE_standard___time___Int___nanosleep;
  fra.me.has_broke = 0;
  fra.me.REG_size = 0;
  fra.me.nitni_local_ref_head = NULL;
  REGB0 = p0;
  /* /home/jp/Projects-ssd/nit/lib/standard/time.nit:28 */
  Int_nanosleep___out(REGB0);
  stack_frame_head = fra.me.prev;
  return;
}
