# $NetBSD: buildlink3.mk,v 1.11 2022/02/12 08:50:31 pho Exp $

BUILDLINK_TREE+=	hs-dlist

.if !defined(HS_DLIST_BUILDLINK3_MK)
HS_DLIST_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.hs-dlist+=	hs-dlist>=1.0
BUILDLINK_ABI_DEPENDS.hs-dlist+=	hs-dlist>=1.0nb3
BUILDLINK_PKGSRCDIR.hs-dlist?=		../../devel/hs-dlist
.endif	# HS_DLIST_BUILDLINK3_MK

BUILDLINK_TREE+=	-hs-dlist
