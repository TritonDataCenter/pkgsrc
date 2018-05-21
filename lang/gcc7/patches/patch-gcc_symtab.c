$NetBSD$

Support -fclone-functions.

--- gcc/symtab.c.orig	2017-04-28 11:42:14.556427000 +0000
+++ gcc/symtab.c
@@ -1744,6 +1744,10 @@ symtab_node::noninterposable_alias (void
   tree new_decl;
   symtab_node *new_node = NULL;
 
+  /* Do not allow a clone to be created if function-cloning is disabled */
+  if (!flag_clone_functions)
+    return NULL;
+
   /* First try to look up existing alias or base object
      (if that is already non-overwritable).  */
   symtab_node *node = ultimate_alias_target ();
