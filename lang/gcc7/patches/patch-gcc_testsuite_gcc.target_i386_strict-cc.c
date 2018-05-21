$NetBSD$

Test -fstrict-calling-conventions.

--- /dev/null	2018-05-21 12:23:16.000000000 +0000
+++ gcc/testsuite/gcc.target/i386/strict-cc.c	2018-05-21 12:11:48.087972286 +0000
@@ -0,0 +1,24 @@
+/* { dg-do compile { target { ilp32 } } } */
+/* { dg-options "-O2 -funit-at-a-time -fstrict-calling-conventions"  } */
+/* { dg-final { scan-assembler "pushl.*\\\$1" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$2" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$3" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$4" } } */
+/* { dg-final { scan-assembler "pushl.*\\\$5" } } */
+
+#include <stdio.h>
+
+/* Verify that local calling convention is not used if strict conventions.  */
+static int t(int, int, int, int, int) __attribute__ ((noinline));
+
+int
+m()
+{
+    t(1, 2, 3, 4, 5);
+}
+
+static int
+t(int a, int b, int c, int d, int e)
+{
+    printf("%d\n", a, b, c, d, e);
+}
