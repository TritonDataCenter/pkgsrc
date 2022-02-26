$NetBSD: patch-synapse_python_dependencies.py,v 1.6 2022/02/25 16:18:36 js Exp $

Patch out cryptography check: It doesn't need a version this high and it was
added by upstream as an ugly hack to force a patched OpenSSL, in case it is
linked statically.

--- synapse/python_dependencies.py.orig	2022-02-22 11:32:11.000000000 +0000
+++ synapse/python_dependencies.py
@@ -84,9 +84,6 @@ REQUIREMENTS = [
     "Jinja2>=2.9",
     "bleach>=1.4.3",
     "typing-extensions>=3.7.4",
-    # We enforce that we have a `cryptography` version that bundles an `openssl`
-    # with the latest security patches.
-    "cryptography>=3.4.7",
     "ijson>=3.1",
     "matrix-common~=1.1.0",
 ]
