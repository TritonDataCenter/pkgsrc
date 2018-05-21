$NetBSD$

Pull in ${PREFIX}/lib by default and handle for multiarch.

--- gcc/config/sol2.h.orig	2017-11-21 09:31:12.000000000 +0000
+++ gcc/config/sol2.h
@@ -241,8 +241,9 @@ along with GCC; see the file COPYING3.  
   "%{G:-G} \
    %{YP,*} \
    %{R*} \
-   %{!YP,*:%{p|pg:-Y P,%R/usr/lib/libp%R/lib:%R/usr/lib} \
-	   %{!p:%{!pg:-Y P,%R/lib:%R/usr/lib}}}"
+   -R@PREFIX@/lib \
+   %{!YP,*:%{p|pg:-Y P,%R/lib:%R/usr/lib:%R@PREFIX@/lib} \
+	   %{!p:%{!pg:-Y P,%R/lib:%R/usr/lib:%R@PREFIX@/lib}}}"
 
 #undef LINK_ARCH32_SPEC
 #define LINK_ARCH32_SPEC LINK_ARCH32_SPEC_BASE
@@ -254,8 +255,9 @@ along with GCC; see the file COPYING3.  
   "%{G:-G} \
    %{YP,*} \
    %{R*} \
-   %{!YP,*:%{p|pg:-Y P,%R/usr/lib/libp/" ARCH64_SUBDIR ":%R/lib/" ARCH64_SUBDIR ":%R/usr/lib/" ARCH64_SUBDIR "}	\
-	   %{!p:%{!pg:-Y P,%R/lib/" ARCH64_SUBDIR ":%R/usr/lib/" ARCH64_SUBDIR "}}}"
+   -R@PREFIX@/lib@MARCH64_SLASH@" @MARCH64_SUBDIR@ " \
+   %{!YP,*:%{p|pg:-Y P,%R/lib/" ARCH64_SUBDIR ":%R/usr/lib/" ARCH64_SUBDIR ":%R@PREFIX@/lib@MARCH64_SLASH@" @MARCH64_SUBDIR@ "} \
+	   %{!p:%{!pg:-Y P,%R/lib/" ARCH64_SUBDIR ":%R/usr/lib/" ARCH64_SUBDIR ":%R@PREFIX@/lib@MARCH64_SLASH@" @MARCH64_SUBDIR@ "}}}"
 
 #undef LINK_ARCH64_SPEC
 #ifndef USE_GLD
