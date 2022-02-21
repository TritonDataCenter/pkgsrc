# $NetBSD: buildlink3.mk,v 1.1 2022/02/16 05:07:23 pho Exp $

BUILDLINK_TREE+=	hs-dependent-map

.if !defined(HS_DEPENDENT_MAP_BUILDLINK3_MK)
HS_DEPENDENT_MAP_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-dependent-map+=	hs-dependent-map>=0.4.0
BUILDLINK_ABI_DEPENDS.hs-dependent-map+=	hs-dependent-map>=0.4.0.0
BUILDLINK_PKGSRCDIR.hs-dependent-map?=		../../devel/hs-dependent-map

.include "../../devel/hs-constraints-extras/buildlink3.mk"
.include "../../devel/hs-dependent-sum/buildlink3.mk"
.endif	# HS_DEPENDENT_MAP_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-dependent-map
