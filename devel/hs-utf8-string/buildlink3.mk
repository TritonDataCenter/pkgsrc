# $NetBSD: buildlink3.mk,v 1.8 2022/02/12 08:50:41 pho Exp $

BUILDLINK_TREE+=	hs-utf8-string

.if !defined(HS_UTF8_STRING_BUILDLINK3_MK)
HS_UTF8_STRING_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-utf8-string+=	hs-utf8-string>=1.0.2
BUILDLINK_ABI_DEPENDS.hs-utf8-string+=	hs-utf8-string>=1.0.2nb3
BUILDLINK_PKGSRCDIR.hs-utf8-string?=	../../devel/hs-utf8-string
.endif	# HS_UTF8_STRING_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-utf8-string
