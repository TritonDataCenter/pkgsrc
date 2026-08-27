$NetBSD: patch-bfd_cache.c,v 1.5 2020/12/06 18:07:53 fcambus Exp $

Fix sign-compare on SunOS.
Handle 256 file descriptor limit in 32-bit SunOS environment.

--- bfd/cache.c.orig	2026-07-25 23:00:00.000000000 +0000
+++ bfd/cache.c
@@ -45,6 +45,10 @@ SUBSECTION
 #include "libbfd.h"
 #include "libiberty.h"
 
+#if defined(__illumos__) && !defined(_LP64)
+#include <limits.h>
+#endif
+
 static FILE *_bfd_open_file_unlocked (bfd *abfd);
 
 /* In some cases we can optimize cache operation when reopening files.
