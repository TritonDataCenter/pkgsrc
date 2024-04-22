# $NetBSD$
#
# Precomputed variables file for macOS trunk.
#
# These variables are only suitable for Sonoma / Xcode 13.4.1 / SDK 12.3!
#

NATIVE_OPSYS=		Darwin
NATIVE_OPSYS_VERSION=	140500
NATIVE_OS_VERSION=	23.5.0
OSX_VERSION=		14.5

# Note that if the Xcode/SDK is ever updated, it is important to regenerate
# the main pkgbuild varcache file too.
#
CC_VERSION=		clang-13.1.6
OSX_PATH_TO_M4=		/usr/bin/m4
OSX_PATH_TO_YACC=	/usr/bin/yacc
OSX_SDK_PATH=		/Applications/Xcode-13.4.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.3.sdk

PKGTOOLS_VERSION=	20240307

UNPRIVILEGED_GROUP=	staff
UNPRIVILEGED_GROUPS=	staff
UNPRIVILEGED_USER=	pbulk
