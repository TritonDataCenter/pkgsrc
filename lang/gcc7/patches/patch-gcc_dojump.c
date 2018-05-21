$NetBSD$

Disable -fomit-frame-pointer.

--- gcc/dojump.c.orig	2017-01-01 12:07:43.905435000 +0000
+++ gcc/dojump.c
@@ -82,7 +82,7 @@ void
 clear_pending_stack_adjust (void)
 {
   if (optimize > 0
-      && (! flag_omit_frame_pointer || cfun->calls_alloca)
+      && (! 0 || cfun->calls_alloca)
       && EXIT_IGNORE_STACK)
     discard_pending_stack_adjust ();
 }
