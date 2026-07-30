$NetBSD$

--- lib/public_key/src/pubkey_os_cacerts.erl.orig	2026-07-01 08:51:45.237156425 +0000
+++ lib/public_key/src/pubkey_os_cacerts.erl
@@ -228,7 +228,8 @@ bsd_paths() ->
 
 sunos_paths() ->
     ["/etc/certs/CA/", %% Oracle Solaris, some older illumos distros
-     "/etc/ssl/cacert.pem" %% OmniOS
+     "/etc/ssl/cacert.pem", %% OmniOS
+     "/etc/ssl/certs/ca-certificates.crt" %% SmartOS
     ].
 
 run_cmd(Cmd, Args) ->
