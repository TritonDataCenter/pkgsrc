$NetBSD: patch-src_syscfg_lock-obj-pub.netbsdelf.h,v 1.1 2024/01/13 04:16:40 riastradh Exp $

Provide a generic NetBSD definition of lock and initializer, for
cross-compilation.

--- src/syscfg/lock-obj-pub.netbsdelf.h.orig	2023-06-15 19:44:14.451323950 +0000
+++ src/syscfg/lock-obj-pub.netbsdelf.h
@@ -0,0 +1,9 @@
+#include <pthread.h>
+
+typedef struct
+{
+  long _vers;
+  pthread_mutex_t u;
+} gpgrt_lock_t;
+
+#define GPGRT_LOCK_INITIALIZER {1, PTHREAD_MUTEX_INITIALIZER}
