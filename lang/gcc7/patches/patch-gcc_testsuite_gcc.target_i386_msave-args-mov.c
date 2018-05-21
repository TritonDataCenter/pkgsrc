$NetBSD$

Test -msave-args.

--- /dev/null	2018-05-21 12:23:16.000000000 +0000
+++ gcc/testsuite/gcc.target/i386/msave-args-mov.c	2018-05-21 12:31:14.365772073 +0000
@@ -0,0 +1,26 @@
+/* { dg-do run { target { { i?86-*-solaris2.* } && lp64 } } } */
+/* { dg-options "-msave-args -mforce-save-regs-using-mov -save-temps" } */
+
+#include <stdio.h>
+
+void t(int, int, int, int, int) __attribute__ ((noinline));
+
+int
+main(int argc, char **argv)
+{
+	t(1, 2, 3, 4, 5);
+	return (0);
+}
+
+void
+t(int a, int b, int c, int d, int e)
+{
+	printf("%d %d %d %d %d", a, b, c, d, e);
+}
+
+/* { dg-final { scan-assembler "movq\t%rdi, -8\\(%rbp\\)" } } */
+/* { dg-final { scan-assembler "movq\t%rsi, -16\\(%rbp\\)" } } */
+/* { dg-final { scan-assembler "movq\t%rdx, -24\\(%rbp\\)" } } */
+/* { dg-final { scan-assembler "movq\t%rcx, -32\\(%rbp\\)" } } */
+/* { dg-final { scan-assembler "movq\t%r8, -40\\(%rbp\\)" } } */
+/* { dg-final { cleanup-saved-temps } } */
