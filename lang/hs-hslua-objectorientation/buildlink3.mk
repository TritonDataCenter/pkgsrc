# $NetBSD: buildlink3.mk,v 1.2 2022/02/12 08:50:43 pho Exp $

BUILDLINK_TREE+=	hs-hslua-objectorientation

.if !defined(HS_HSLUA_OBJECTORIENTATION_BUILDLINK3_MK)
HS_HSLUA_OBJECTORIENTATION_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-hslua-objectorientation+=	hs-hslua-objectorientation>=2.1.0
BUILDLINK_ABI_DEPENDS.hs-hslua-objectorientation+=	hs-hslua-objectorientation>=2.1.0nb1
BUILDLINK_PKGSRCDIR.hs-hslua-objectorientation?=	../../lang/hs-hslua-objectorientation

.include "../../lang/hs-hslua-core/buildlink3.mk"
.include "../../lang/hs-hslua-marshalling/buildlink3.mk"
.endif	# HS_HSLUA_OBJECTORIENTATION_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-hslua-objectorientation
