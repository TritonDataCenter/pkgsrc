$NetBSD: patch-ext_bifrost_src_BitContainer.cpp,v 1.3 2024/09/20 00:03:15 bacon Exp $

# vfscanf() not found on NetBSD 9

--- ext/bifrost/src/BitContainer.cpp.orig	2023-11-01 12:46:19.000000000 +0000
+++ ext/bifrost/src/BitContainer.cpp
@@ -1,3 +1,4 @@
+#include <cstdio>
 #include "BitContainer.hpp"
 
 BitContainer::BitContainer() : setBits(localBitVector) {}
