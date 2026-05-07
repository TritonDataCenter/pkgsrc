$NetBSD$

Avoid dprintf until we've bumped to a platform that contains it.
XXX: not for upstream

--- src/tpm_library.c.orig	2026-05-07 13:31:54.758497397 +0000
+++ src/tpm_library.c
@@ -524,8 +524,8 @@ int TPMLIB_LogPrintf(const char *format,
     }
 
     if (debug_prefix)
-        dprintf(debug_fd, "%s", debug_prefix);
-    dprintf(debug_fd, "%s", buffer);
+        write(debug_fd, debug_prefix, strlen(debug_prefix));
+    write(debug_fd, buffer, n);
 
     return i;
 }
@@ -542,7 +542,9 @@ void TPMLIB_LogPrintfA(unsigned int inde
 {
     va_list args;
     char spaces[20];
+    char buffer[BUFSIZ];
     int fd;
+    int n;
 
     if (indent != (unsigned int)~0) {
         if (!debug_fd || !debug_level)
@@ -557,13 +559,15 @@ void TPMLIB_LogPrintfA(unsigned int inde
         if (indent > sizeof(spaces) - 1)
             indent = sizeof(spaces) - 1;
         memset(spaces, ' ', indent);
-        spaces[indent] = 0;
-        dprintf(fd, "%s", spaces);
+        write(fd, spaces, indent);
     }
 
     va_start(args, format);
-    vdprintf(fd, format, args);
+    n = vsnprintf(buffer, sizeof(buffer), format, args);
     va_end(args);
+
+    if (n > 0)
+        write(fd, buffer, n < (int)sizeof(buffer) ? (size_t)n : sizeof(buffer) - 1);
 }
 
 /*
