$NetBSD$

Test -fstrict-calling-conventions.

--- gcc/testsuite/gcc.target/i386/local.c.orig	2015-12-29 10:32:21.184118000 +0000
+++ gcc/testsuite/gcc.target/i386/local.c
@@ -1,5 +1,6 @@
 /* { dg-do compile } */
-/* { dg-options "-O2 -funit-at-a-time" } */
+/* { dg-options "-O2 -funit-at-a-time -fno-strict-calling-conventions" { target ia32 } } */
+/* { dg-options "-O2 -funit-at-a-time" { target lp64 } } */
 /* { dg-final { scan-assembler "magic\[^\\n\]*eax" { target ia32 } } } */
 /* { dg-final { scan-assembler "magic\[^\\n\]*(edi|ecx)" { target { ! ia32 } } } } */
 
