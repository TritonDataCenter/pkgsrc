.include "${PKGSRCDIR}/mk/pkgformat/pkg/pkgformat-vars.mk"

IPS_PUBLISHER?=		pkgsrc
IPS_REPO?=		${PACKAGES}/ips
IPS_BRANCH?=		0
IPS_BUILD_RELEASE?=	5.11
IPS_LOCAL_MOG?=		${PKGDIR}/local.mog

PKGSEND?=		pkgsend
PKGMOGRIFY?=		pkgmogrify
PKGFMT?=		pkgfmt
PKGREPO?=		pkgrepo
