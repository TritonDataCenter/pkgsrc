# $NetBSD: buildlink3.mk,v 1.5 2024/01/30 14:22:18 ryoon Exp $

BUILDLINK_TREE+=	kdepim-runtime

.if !defined(KDEPIM_RUNTIME_BUILDLINK3_MK)
KDEPIM_RUNTIME_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.kdepim-runtime+=	kdepim-runtime>=20.04.1
BUILDLINK_ABI_DEPENDS.kdepim-runtime?=	kdepim-runtime>=23.04.3nb5
BUILDLINK_PKGSRCDIR.kdepim-runtime?=	../../misc/kdepim-runtime

.include "../../devel/knotifyconfig/buildlink3.mk"
.include "../../misc/akonadi-notes/buildlink3.mk"
.include "../../misc/pimcommon/buildlink3.mk"
.include "../../time/akonadi-calendar/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# KDEPIM_RUNTIME_BUILDLINK3_MK

BUILDLINK_TREE+=	-kdepim-runtime
