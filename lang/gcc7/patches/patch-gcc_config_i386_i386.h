$NetBSD$

Support -msave-args.

--- gcc/config/i386/i386.h.orig	2018-01-16 11:10:44.253204000 +0000
+++ gcc/config/i386/i386.h
@@ -2480,6 +2480,7 @@ enum avx_u128_state
   */
 struct GTY(()) ix86_frame
 {
+  int nmsave_args;
   int nsseregs;
   int nregs;
   int va_arg_size;
@@ -2491,6 +2492,7 @@ struct GTY(()) ix86_frame
   HOST_WIDE_INT hard_frame_pointer_offset;
   HOST_WIDE_INT stack_pointer_offset;
   HOST_WIDE_INT hfp_save_offset;
+  HOST_WIDE_INT arg_save_offset;
   HOST_WIDE_INT reg_save_offset;
   HOST_WIDE_INT sse_reg_save_offset;
 
