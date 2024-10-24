$NetBSD: patch-third__party_js_cfworker_build.sh,v 1.1 2024/08/18 15:02:21 leot Exp $

shell portability

--- third_party/js/cfworker/build.sh.orig	2022-04-28 22:03:47.000000000 +0000
+++ third_party/js/cfworker/build.sh
@@ -4,9 +4,10 @@ set -euo pipefail
 # Path to mach relative to /third_party/js/cfworker
 MACH=$(realpath "../../../mach")
 
-if [[ $(uname -a) == *MSYS* ]]; then
-  MACH="python ${MACH}"
-fi
+# uname -a is not a good idea here. Someone could have MSYS in the hostname.
+#if uname -a | grep MSYS > /dev/null; then
+#  MACH="python ${MACH}"
+#fi
 
 NODE="${MACH} node"
 NPM="${MACH} npm"
