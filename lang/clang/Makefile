# $NetBSD: Makefile,v 1.101 2026/11/11 11:54:12 wiz Exp $

PKGREVISION= 3
.include "Makefile.common"

PKGNAME=	clang-${LLVM_VERSION}

COMMENT=	C language family frontend for LLVM

USE_TOOLS+=	perl:run

# Install clang python bindings
CMAKE_CONFIGURE_ARGS+=	-DCLANG_PYTHON_BINDINGS_VERSIONS=${PYVERSSUFFIX}
PLIST_SUBST+=		PYSITELIB=${PYSITELIB}

# Certain header files are generated, and can only be generated
# if llvm has support for the target.
PLIST_VARS+=	RISCV
.if ${PKG_BUILD_OPTIONS.llvm:Mllvm-target-riscv}
PLIST.RISCV=	yes
.endif

PLIST_VARS+=	ARM
.if	${PKG_BUILD_OPTIONS.llvm:Mllvm-target-arm} ||	\
	${PKG_BUILD_OPTIONS.llvm:Mllvm-target-aarch64}
PLIST.ARM=	yes
.endif

# libclang-cpp.so uses connect(), socket(), ...
LDFLAGS.SunOS+=	-lsocket

# XXX: Move files to gcc-libs and drop full dependency.  This is obviously
# highly specific to illumos/x86_64 and must not be copied elsewhere.
.PHONY: create-clang-cfg
post-install: create-clang-cfg
create-clang-cfg:
	${RUN} p=`${_GCC_PREFIX}bin/gcc -print-libgcc-file-name 2>/dev/null`; \
	    d=`dirname $$p`; ${ECHO} '--gcc-install-dir='$$d \
	    > ${DESTDIR}${PREFIX}/bin/x86_64-pc-solaris2.11.cfg

.include "../../mk/atomic64.mk"
.include "../../mk/bsd.pkg.mk"
