# $NetBSD: buildlink3.mk,v 1.1 2022/02/24 01:02:19 pho Exp $

BUILDLINK_TREE+=	hs-basic-prelude

.if !defined(HS_BASIC_PRELUDE_BUILDLINK3_MK)
HS_BASIC_PRELUDE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-basic-prelude+=	hs-basic-prelude>=0.7.0
BUILDLINK_ABI_DEPENDS.hs-basic-prelude+=	hs-basic-prelude>=0.7.0
BUILDLINK_PKGSRCDIR.hs-basic-prelude?=		../../devel/hs-basic-prelude

.include "../../devel/hs-hashable/buildlink3.mk"
.include "../../devel/hs-unordered-containers/buildlink3.mk"
.include "../../devel/hs-vector/buildlink3.mk"
.endif	# HS_BASIC_PRELUDE_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-basic-prelude
