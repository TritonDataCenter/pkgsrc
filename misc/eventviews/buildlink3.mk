# $NetBSD: buildlink3.mk,v 1.5 2024/01/30 14:22:16 ryoon Exp $

BUILDLINK_TREE+=	eventviews

.if !defined(EVENTVIEWS_BUILDLINK3_MK)
EVENTVIEWS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.eventviews+=	eventviews>=20.04.1
BUILDLINK_ABI_DEPENDS.eventviews?=	eventviews>=23.04.3nb4
BUILDLINK_PKGSRCDIR.eventviews?=	../../misc/eventviews

.include "../../graphics/kdiagram/buildlink3.mk"
.include "../../time/calendarsupport/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# EVENTVIEWS_BUILDLINK3_MK

BUILDLINK_TREE+=	-eventviews
