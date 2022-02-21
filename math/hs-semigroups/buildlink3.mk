# $NetBSD: buildlink3.mk,v 1.16 2022/02/12 08:50:45 pho Exp $

BUILDLINK_TREE+=	hs-semigroups

.if !defined(HS_SEMIGROUPS_BUILDLINK3_MK)
HS_SEMIGROUPS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-semigroups+=	hs-semigroups>=0.20
BUILDLINK_ABI_DEPENDS.hs-semigroups+=	hs-semigroups>=0.20nb1
BUILDLINK_PKGSRCDIR.hs-semigroups?=	../../math/hs-semigroups

.include "../../devel/hs-hashable/buildlink3.mk"
.include "../../devel/hs-tagged/buildlink3.mk"
.include "../../devel/hs-transformers-compat/buildlink3.mk"
.include "../../devel/hs-unordered-containers/buildlink3.mk"
.endif	# HS_SEMIGROUPS_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-semigroups
