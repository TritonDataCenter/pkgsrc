$NetBSD$

Test -fclone-functions.

--- /dev/null	2018-05-21 12:23:16.000000000 +0000
+++ gcc/testsuite/gcc.dg/fno-clone-preserves-unused-args.c	2018-05-21 12:14:37.563084208 +0000
@@ -0,0 +1,27 @@
+/* { dg-do compile { target { ilp32 } } } */
+/* { dg-options "-O2 -funit-at-a-time -fipa-sra -fno-clone-functions"  } */
+/* { dg-final { scan-assembler "pushl.*\\\$1" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$2" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$3" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$4" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$5" } } */
+
+#include <stdio.h>
+
+/*
+ * Verify that preventing function cloning prevents constant prop/scalar
+ * reduction removing parameters
+ */
+static void
+t(int, int, int, int, int) __attribute__ ((noinline));
+
+int void()
+{
+    t(1, 2, 3, 4, 5);
+}
+
+/* Only use 3 params, bait constprop/sra into deleting the other two */
+static void(int a, int b, int c, int d, int e)
+{
+    printf("%d %d\n", a, b, c);
+}
