# $NetBSD: buildlink3.mk,v 1.1 2022/02/23 16:17:41 pho Exp $

BUILDLINK_TREE+=	hs-mtl-compat

.if !defined(HS_MTL_COMPAT_BUILDLINK3_MK)
HS_MTL_COMPAT_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-mtl-compat+=	hs-mtl-compat>=0.2.2
BUILDLINK_ABI_DEPENDS.hs-mtl-compat+=	hs-mtl-compat>=0.2.2
BUILDLINK_PKGSRCDIR.hs-mtl-compat?=	../../devel/hs-mtl-compat
.endif	# HS_MTL_COMPAT_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-mtl-compat
