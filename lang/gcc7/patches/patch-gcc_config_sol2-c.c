$NetBSD$

Update cmn_err format specifier.

--- gcc/config/sol2-c.c.orig	2017-01-01 12:07:43.905435000 +0000
+++ gcc/config/sol2-c.c
@@ -40,7 +40,10 @@ static const format_length_info cmn_err_
 
 static const format_flag_spec cmn_err_flag_specs[] =
 {
+  { '0',  0, 0, N_("'0' flag"),        N_("the '0' flag"),                     STD_C89 },
+  { '-',  0, 0, N_("'-' flag"),        N_("the '-' flag"),                     STD_C89 },
   { 'w',  0, 0, N_("field width"),     N_("field width in printf format"),     STD_C89 },
+  { 'p',  0, 0, N_("precision"),       N_("precision in printf format"),       STD_C89 },
   { 'L',  0, 0, N_("length modifier"), N_("length modifier in printf format"), STD_C89 },
   { 0, 0, 0, NULL, NULL, STD_C89 }
 };
@@ -48,6 +51,7 @@ static const format_flag_spec cmn_err_fl
 
 static const format_flag_pair cmn_err_flag_pairs[] =
 {
+  { '0', '-', 1, 0 },
   { 0, 0, 0, 0 }
 };
 
@@ -57,21 +61,21 @@ static const format_char_info bitfield_s
 static const format_char_info cmn_err_char_table[] =
 {
   /* C89 conversion specifiers.  */
-  { "dD",  0, STD_C89, { T89_I,   BADLEN,  BADLEN,  T89_L,   T9L_LL,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w",  "",   NULL },
-  { "oOxX",0, STD_C89, { T89_UI,  BADLEN,  BADLEN,  T89_UL,  T9L_ULL, BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w",  "",   NULL },
-  { "u",   0, STD_C89, { T89_UI,  BADLEN,  BADLEN,  T89_UL,  T9L_ULL, BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w",  "",   NULL },
-  { "c",   0, STD_C89, { T89_C,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w",  "",   NULL },
-  { "p",   1, STD_C89, { T89_V,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w", "c",  NULL },
-  { "s",   1, STD_C89, { T89_C,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w",  "cR", NULL },
-  { "b",   0, STD_C89, { T89_I,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "w",   "",   &bitfield_string_type },
+  { "dD",  0, STD_C89, { T89_I,   BADLEN,  BADLEN,  T89_L,   T9L_LL,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-wp0", "",   NULL },
+  { "oOxX",0, STD_C89, { T89_UI,  BADLEN,  BADLEN,  T89_UL,  T9L_ULL, BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-wp0", "",   NULL },
+  { "u",   0, STD_C89, { T89_UI,  BADLEN,  BADLEN,  T89_UL,  T9L_ULL, BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-wp0", "",   NULL },
+  { "c",   0, STD_C89, { T89_C,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-w",   "",   NULL },
+  { "p",   1, STD_C89, { T89_V,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-w",   "c",  NULL },
+  { "s",   1, STD_C89, { T89_C,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-wp",  "cR", NULL },
+  { "b",   0, STD_C89, { T89_I,   BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN,  BADLEN  }, "-w0",  "",   &bitfield_string_type },
   { NULL,  0, STD_C89, NOLENGTHS, NULL, NULL, NULL }
 };
 
 EXPORTED_CONST format_kind_info solaris_format_types[] = {
-  { "cmn_err",  cmn_err_length_specs,  cmn_err_char_table, "", NULL,
+  { "cmn_err",  cmn_err_length_specs,  cmn_err_char_table, "0-", NULL,
     cmn_err_flag_specs, cmn_err_flag_pairs,
     FMT_FLAG_ARG_CONVERT|FMT_FLAG_EMPTY_PREC_OK,
-    'w', 0, 0, 0, 'L', 0,
+    'w', 0, 'p', 0, 'L', 0,
     &integer_type_node, &integer_type_node
   }
 };
