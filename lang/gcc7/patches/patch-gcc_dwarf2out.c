$NetBSD$

Support -msave-args.

--- gcc/dwarf2out.c.orig	2017-11-15 11:54:11.986064000 +0000
+++ gcc/dwarf2out.c
@@ -22432,6 +22432,11 @@ gen_subprogram_die (tree decl, dw_die_re
     /* Add the calling convention attribute if requested.  */
     add_calling_convention_attribute (subr_die, decl);
 
+#ifdef TARGET_SAVE_ARGS
+  if (TARGET_SAVE_ARGS)
+    add_AT_flag (subr_die, DW_AT_SUN_amd64_parmdump, 1);
+#endif
+
   /* Output Dwarf info for all of the stuff within the body of the function
      (if it has one - it may be just a declaration).
 
