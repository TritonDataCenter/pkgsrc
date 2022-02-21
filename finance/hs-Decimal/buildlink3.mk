# $NetBSD: buildlink3.mk,v 1.5 2022/02/12 08:50:42 pho Exp $

BUILDLINK_TREE+=	hs-Decimal

.if !defined(HS_DECIMAL_BUILDLINK3_MK)
HS_DECIMAL_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-Decimal+=	hs-Decimal>=0.5.2
BUILDLINK_ABI_DEPENDS.hs-Decimal+=	hs-Decimal>=0.5.2nb3
BUILDLINK_PKGSRCDIR.hs-Decimal?=	../../finance/hs-Decimal
.endif	# HS_DECIMAL_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-Decimal
