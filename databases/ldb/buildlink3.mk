# $NetBSD: buildlink3.mk,v 1.7 2024/04/15 07:15:36 adam Exp $

BUILDLINK_TREE+=	ldb

.if !defined(LDB_BUILDLINK3_MK)
LDB_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.ldb+=	ldb>=2.4.0
BUILDLINK_ABI_DEPENDS.ldb+=	ldb>=2.7.2nb1
BUILDLINK_PKGSRCDIR.ldb?=	../../databases/ldb

.include "../../converters/libiconv/buildlink3.mk"
.include "../../databases/tdb/buildlink3.mk"
.include "../../devel/popt/buildlink3.mk"
.include "../../devel/talloc/buildlink3.mk"
.include "../../devel/tevent/buildlink3.mk"
.endif	# LDB_BUILDLINK3_MK

BUILDLINK_TREE+=	-ldb
