# $NetBSD: buildlink3.mk,v 1.36 2024/01/30 14:22:25 ryoon Exp $

BUILDLINK_TREE+=	libkcddb

.if !defined(LIBKCDDB_BUILDLINK3_MK)
LIBKCDDB_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.libkcddb+=	libkcddb>=19.08.3
BUILDLINK_ABI_DEPENDS.libkcddb?=	libkcddb>=23.04.3nb4
BUILDLINK_PKGSRCDIR.libkcddb?=	../../multimedia/libkcddb

.include "../../audio/libmusicbrainz5/buildlink3.mk"
.include "../../devel/kcmutils/buildlink3.mk"
.include "../../devel/kio/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# LIBKCDDB_BUILDLINK3_MK

BUILDLINK_TREE+=	-libkcddb
