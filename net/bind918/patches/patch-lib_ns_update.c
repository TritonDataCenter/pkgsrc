$NetBSD: patch-lib_ns_update.c,v 1.2 2023/02/08 00:13:44 taca Exp $

* Based on NetBSD, add support for blocklist(blacklist).

--- lib/ns/update.c.orig	2023-01-12 22:21:15.274402517 +0000
+++ lib/ns/update.c
@@ -55,6 +55,10 @@
 #include <ns/stats.h>
 #include <ns/update.h>
 
+#if defined(HAVE_BLACKLIST_H) || defined(HAVE_BLOCKLIST_H)
+#include <ns/pfilter.h>
+#endif
+
 /*! \file
  * \brief
  * This module implements dynamic update as in RFC2136.
@@ -358,6 +362,9 @@ checkqueryacl(ns_client_t *client, dns_a
 	if (result != ISC_R_SUCCESS) {
 		int level = update_possible ? ISC_LOG_ERROR : ISC_LOG_INFO;
 
+#if defined(HAVE_BLACKLIST_H) || defined(HAVE_BLOCKLIST_H)
+		pfilter_notify(result, client, "queryacl");
+#endif
 		dns_name_format(zonename, namebuf, sizeof(namebuf));
 		dns_rdataclass_format(client->view->rdclass, classbuf,
 				      sizeof(classbuf));
@@ -367,6 +374,9 @@ checkqueryacl(ns_client_t *client, dns_a
 			      "update '%s/%s' denied due to allow-query",
 			      namebuf, classbuf);
 	} else if (!update_possible) {
+#if defined(HAVE_BLACKLIST_H) || defined(HAVE_BLOCKLIST_H)
+		pfilter_notify(result, client, "updateacl");
+#endif
 		dns_name_format(zonename, namebuf, sizeof(namebuf));
 		dns_rdataclass_format(client->view->rdclass, classbuf,
 				      sizeof(classbuf));
@@ -409,6 +419,9 @@ checkupdateacl(ns_client_t *client, dns_
 		msg = "disabled";
 	} else {
 		result = ns_client_checkaclsilent(client, NULL, acl, false);
+#if defined(HAVE_BLACKLIST_H) || defined(HAVE_BLOCKLIST_H)
+		pfilter_notify(result, client, "updateacl");
+#endif
 		if (result == ISC_R_SUCCESS) {
 			level = ISC_LOG_DEBUG(3);
 			msg = "approved";
