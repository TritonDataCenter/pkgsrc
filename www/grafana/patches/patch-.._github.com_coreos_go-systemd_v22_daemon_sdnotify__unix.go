$NetBSD: patch-.._github.com_coreos_go-systemd_v22_daemon_sdnotify__unix.go,v 1.2 2026/11/14 14:14:24 wiz Exp $

unix.CLOCK_MONOTONIC undefined on at least NetBSD/aarch64.
https://github.com/coreos/go-systemd/issues/512

--- ../github.com/coreos/go-systemd/v22/daemon/sdnotify_unix.go.orig	2026-08-18 21:53:24.536759376 +0000
+++ ../github.com/coreos/go-systemd/v22/daemon/sdnotify_unix.go
@@ -12,7 +12,7 @@
 // See the License for the specific language governing permissions and
 // limitations under the License.
 
-//go:build unix
+//go:build unix && !netbsd
 
 package daemon
 
