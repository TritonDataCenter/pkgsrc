# $NetBSD: buildlink3.mk,v 1.2 2022/02/12 08:50:35 pho Exp $

BUILDLINK_TREE+=	hs-microlens-th

.if !defined(HS_MICROLENS_TH_BUILDLINK3_MK)
HS_MICROLENS_TH_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-microlens-th+=	hs-microlens-th>=0.4.3
BUILDLINK_ABI_DEPENDS.hs-microlens-th+=	hs-microlens-th>=0.4.3.10nb1
BUILDLINK_PKGSRCDIR.hs-microlens-th?=	../../devel/hs-microlens-th

.include "../../devel/hs-microlens/buildlink3.mk"
.include "../../devel/hs-th-abstraction/buildlink3.mk"
.endif	# HS_MICROLENS_TH_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-microlens-th
