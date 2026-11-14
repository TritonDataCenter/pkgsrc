# $NetBSD: Makefile,v 1.44 2026/11/14 14:01:04 ktnb Exp $

DISTNAME=	tailscale
PKGNAME=	tailscale-1.104.7
CATEGORIES=	net
MASTER_SITES=	${MASTER_SITE_GITHUB:=NuclearKev/}
GITHUB_PROJECT=	tailscale
GITHUB_TAG=	8be39b2724cc3feba98aa78728a8c9f0daca49c0

MAINTAINER=	ktnb@NetBSD.org
HOMEPAGE=	https://tailscale.com/
COMMENT=	Wireguard-based VPN client for tailscale
LICENSE=	modified-bsd

GO_BUILD_PATTERN+=	tailscale.com/cmd/tailscale
GO_BUILD_PATTERN+=	tailscale.com/cmd/tailscaled

SUBST_CLASSES+=		paths
SUBST_STAGE.paths=	pre-configure
SUBST_FILES.paths=	paths/paths_unix.go paths/paths.go
SUBST_VARS.paths=	VARBASE

OWN_DIRS_PERMS+=	${VARBASE}/db/tailscale ${REAL_ROOT_USER} ${REAL_ROOT_GROUP} 0700

BUILD_DEFS+=		VARBASE

RCD_SCRIPTS+=	tailscaled

GOFLAGS=	-ldflags "-X tailscale.com/version.longStamp=${PKGVERSION_NOREV} \
		-X tailscale.com/version.shortStamp=${PKGVERSION_NOREV}"

.include "go-modules.mk"

.include "../../lang/go/go-module.mk"
.include "../../mk/bsd.pkg.mk"
