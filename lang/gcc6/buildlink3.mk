# $NetBSD: buildlink3.mk,v 1.5 2023/08/14 05:24:43 wiz Exp $

BUILDLINK_TREE+=	gcc6

.if !defined(GCC6_BUILDLINK3_MK)
GCC6_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.gcc6+=	gcc6>=${_GCC_REQD}
BUILDLINK_ABI_DEPENDS.gcc6+=	gcc6>=6.5.0nb9
BUILDLINK_PKGSRCDIR.gcc6=	../../lang/gcc6

.if ${USE_PKGSRC_GCC_RUNTIME:U:tl} == "yes"
BUILDLINK_DEPMETHOD.gcc6?=	build
.endif

BUILDLINK_PASSTHRU_DIRS+=	${BUILDLINK_PREFIX.gcc6}/gcc6
BUILDLINK_FILES.gcc6=		#empty
BUILDLINK_AUTO_VARS.gcc6=	no

pkgbase := gcc6
.include "../../mk/pkg-build-options.mk"
.if !empty(PKG_BUILD_OPTIONS.gcc6:Mgcc-java)
.include "../../devel/zlib/buildlink3.mk"
.endif

.include "../../mk/dlopen.buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.endif # GCC6_BUILDLINK3_MK

BUILDLINK_TREE+=	-gcc6
