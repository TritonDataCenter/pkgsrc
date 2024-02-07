# $NetBSD: buildlink3.mk,v 1.5 2024/01/30 14:22:16 ryoon Exp $

BUILDLINK_TREE+=	akonadi-contacts

.if !defined(AKONADI_CONTACTS_BUILDLINK3_MK)
AKONADI_CONTACTS_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.akonadi-contacts+=	akonadi-contacts>=17.12.1
BUILDLINK_ABI_DEPENDS.akonadi-contacts?=		akonadi-contacts>=23.04.3nb4
BUILDLINK_PKGSRCDIR.akonadi-contacts?=		../../misc/akonadi-contacts

.include "../../graphics/prison/buildlink3.mk"
.include "../../mail/akonadi-mime/buildlink3.mk"
.include "../../mail/kmime/buildlink3.mk"
.include "../../misc/grantleetheme/buildlink3.mk"
.include "../../misc/kcontacts/buildlink3.mk"
.include "../../security/libkleo/buildlink3.mk"
.include "../../x11/qt5-qtbase/buildlink3.mk"
.endif	# AKONADI_CONTACTS_BUILDLINK3_MK

BUILDLINK_TREE+=	-akonadi-contacts
