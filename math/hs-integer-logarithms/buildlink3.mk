# $NetBSD: buildlink3.mk,v 1.6 2022/02/12 08:50:44 pho Exp $

BUILDLINK_TREE+=	hs-integer-logarithms

.if !defined(HS_INTEGER_LOGARITHMS_BUILDLINK3_MK)
HS_INTEGER_LOGARITHMS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-integer-logarithms+=	hs-integer-logarithms>=1.0.3
BUILDLINK_ABI_DEPENDS.hs-integer-logarithms+=	hs-integer-logarithms>=1.0.3.1nb4
BUILDLINK_PKGSRCDIR.hs-integer-logarithms?=	../../math/hs-integer-logarithms
.endif	# HS_INTEGER_LOGARITHMS_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-integer-logarithms
