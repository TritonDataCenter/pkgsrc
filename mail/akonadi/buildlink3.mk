# $NetBSD: buildlink3.mk,v 1.42 2024/01/30 14:22:12 ryoon Exp $

BUILDLINK_TREE+=	akonadi

.if !defined(AKONADI_BUILDLINK3_MK)
AKONADI_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.akonadi+=	akonadi>=17.12.1
BUILDLINK_ABI_DEPENDS.akonadi?=	akonadi>=23.04.3nb4
BUILDLINK_PKGSRCDIR.akonadi?=	../../mail/akonadi

BUILDLINK_FILES.akonadi+=	share/dbus-1/interfaces/org.freedesktop.Akonadi.*.xml
BUILDLINK_FILES.akonadi+=	share/kf5/akonadi/kcfg2dbus.xsl

.include "../../devel/kio/buildlink3.mk"
.include "../../devel/kitemmodels/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# AKONADI_BUILDLINK3_MK

BUILDLINK_TREE+=	-akonadi
