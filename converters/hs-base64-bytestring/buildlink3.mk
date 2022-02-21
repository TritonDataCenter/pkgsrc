# $NetBSD: buildlink3.mk,v 1.8 2022/02/12 08:50:26 pho Exp $

BUILDLINK_TREE+=	hs-base64-bytestring

.if !defined(HS_BASE64_BYTESTRING_BUILDLINK3_MK)
HS_BASE64_BYTESTRING_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-base64-bytestring+=	hs-base64-bytestring>=1.2.1
BUILDLINK_ABI_DEPENDS.hs-base64-bytestring+=	hs-base64-bytestring>=1.2.1.0nb1
BUILDLINK_PKGSRCDIR.hs-base64-bytestring?=	../../converters/hs-base64-bytestring
.endif	# HS_BASE64_BYTESTRING_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-base64-bytestring
