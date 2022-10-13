# $NetBSD$

BUILDLINK_TREE+=	libnbcompat

.if !defined(LIBNBCOMPAT_BUILDLINK3_MK)
LIBNBCOMPAT_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libnbcompat+=	libnbcompat>=20221013
BUILDLINK_PKGSRCDIR.libnbcompat?=	../../pkgtools/libnbcompat
BUILDLINK_DEPMETHOD.libnbcompat?=	build

BUILDLINK_CPPFLAGS.libnbcompat+=	-DHAVE_NBCOMPAT_H=1
BUILDLINK_LIBS.libnbcompat+=		-lnbcompat
.endif # LIBNBCOMPAT_BUILDLINK3_MK

BUILDLINK_TREE+=	-libnbcompat
