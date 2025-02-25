$NetBSD$

Support mozilla-rootcerts.

--- lib/public_key/src/pubkey_os_cacerts.erl.orig	2025-02-25 10:22:16.838500812 +0000
+++ lib/public_key/src/pubkey_os_cacerts.erl
@@ -184,7 +184,8 @@ store(CaCerts) ->
     persistent_term:put(?MODULE, CaCerts).
 
 linux_paths() ->
-    ["/etc/ssl/certs/ca-certificates.crt",                %% Debian, Ubuntu, Gentoo
+    ["@SYSCONFBASE@/openssl/certs/ca-certificates.crt",
+     "/etc/ssl/certs/ca-certificates.crt",                %% Debian, Ubuntu, Gentoo
      "/etc/pki/tls/certs/ca-bundle.crt",                  %% Fedora, RHEL 6, Amazon Linux
      "/etc/ssl/ca-bundle.pem",                            %% OpenSUSE
      "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem", %% CentOS, RHEL 7
@@ -192,14 +193,16 @@ linux_paths() ->
     ].
 
 bsd_paths() ->
-    ["/etc/ssl/cert.pem",
+    ["@SYSCONFBASE@/openssl/certs/ca-certificates.crt",
+     "/etc/ssl/cert.pem",
      "/etc/openssl/certs/cacert.pem",   %% netbsd (if installed)
      "/etc/openssl/certs/ca-certificates.crt",
      "/usr/local/share/certs/ca-root-nss.crt"
     ].
 
 sunos_paths() ->
-    ["/etc/certs/CA/", %% Oracle Solaris, some older illumos distros
+    ["@SYSCONFBASE@/openssl/certs/ca-certificates.crt",
+     "/etc/certs/CA/", %% Oracle Solaris, some older illumos distros
      "/etc/ssl/cacert.pem" %% OmniOS
     ].
 
