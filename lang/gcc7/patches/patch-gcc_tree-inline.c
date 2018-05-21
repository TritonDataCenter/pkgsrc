$NetBSD$

Support -fclone-functions.

--- gcc/tree-inline.c.orig	2017-10-27 20:33:35.593168000 +0000
+++ gcc/tree-inline.c
@@ -5714,6 +5714,7 @@ bool
 tree_versionable_function_p (tree fndecl)
 {
   return (!lookup_attribute ("noclone", DECL_ATTRIBUTES (fndecl))
+	  && flag_clone_functions
 	  && copy_forbidden (DECL_STRUCT_FUNCTION (fndecl)) == NULL);
 }
 
