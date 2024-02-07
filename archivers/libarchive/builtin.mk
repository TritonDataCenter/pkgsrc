# $NetBSD: builtin.mk,v 1.15 2024/01/24 23:18:03 adam Exp $

BUILTIN_PKG:=	libarchive

BUILTIN_FIND_HEADERS_VAR:=	H_ARCHIVE
BUILTIN_FIND_HEADERS.H_ARCHIVE=	archive.h

.include "../../mk/buildlink3/bsd.builtin.mk"

###
### Determine if there is a built-in implementation of the package and
### set IS_BUILTIN.<pkg> appropriately ("yes" or "no").
###
.if !defined(IS_BUILTIN.libarchive)
IS_BUILTIN.libarchive=	no
.  if empty(H_ARCHIVE:M__nonexistent__) && empty(H_ARCHIVE:M${LOCALBASE}/*)
IS_BUILTIN.libarchive=	yes
.  endif
.endif
MAKEVARS+=		IS_BUILTIN.libarchive

###
### If there is a built-in implementation, then set BUILTIN_PKG.<pkg> to
### a package name to represent the built-in package.
###
.if !defined(BUILTIN_PKG.libarchive) && \
    ${IS_BUILTIN.libarchive:tl} == yes && \
    empty(H_ARCHIVE:M__nonexistent__)
BUILTIN_VERSION.libarchive!=						\
	${AWK} '/\#define[ 	]*ARCHIVE_LIBRARY_VERSION/ {		\
			lib_vers = $$4;					\
			gsub("\"", "", lib_vers);			\
			if (found == 0)					\
			    found=1;					\
		}							\
		/\#define[ 	]*ARCHIVE_VERSION_ONLY_STRING/ {	\
			vers_str = $$3;					\
			gsub("\"", "", vers_str);			\
			found=2;					\
		}							\
		/\#define[ 	]*ARCHIVE_VERSION_STRING/ {		\
			if (found == 0) {				\
				vers_str = $$4;				\
				gsub("\"", "", vers_str);		\
				found=2;				\
			}						\
		}							\
		END {							\
			if (!found)					\
				print;					\
			else if (found == 1)				\
				print lib_vers;				\
			else if (found == 2)				\
				print vers_str;				\
		}							\
	' ${_CROSS_DESTDIR:U:Q}${H_ARCHIVE:Q}
.  if !empty(BUILTIN_VERSION.libarchive)
BUILTIN_PKG.libarchive=	libarchive-${BUILTIN_VERSION.libarchive}
.  else
IS_BUILTIN.libarchive=	no
.  endif
.endif
MAKEVARS+=		BUILTIN_PKG.libarchive

###
### Determine whether we should use the built-in implementation if it
### exists, and set USE_BUILTIN.<pkg> appropriate ("yes" or "no").
###
.if !defined(USE_BUILTIN.libarchive)
.  if ${PREFER.libarchive} == "pkgsrc"
USE_BUILTIN.libarchive=	no
.  else
USE_BUILTIN.libarchive=	${IS_BUILTIN.libarchive}
.    if defined(BUILTIN_PKG.libarchive) && \
        ${IS_BUILTIN.libarchive:tl} == yes
USE_BUILTIN.libarchive=	yes
.      for _dep_ in ${BUILDLINK_API_DEPENDS.libarchive}
.        if ${USE_BUILTIN.libarchive:tl} == yes
USE_BUILTIN.libarchive!=	\
	if ${PKG_ADMIN} pmatch ${_dep_:Q} ${BUILTIN_PKG.libarchive}; then \
		${ECHO} yes;						\
	else								\
		${ECHO} no;						\
	fi
.        endif
.      endfor
.    endif
.  endif  # PREFER.libarchive
.endif
MAKEVARS+=		USE_BUILTIN.libarchive

###
### The section below only applies if we are not including this file
### solely to determine whether a built-in implementation exists.
###
CHECK_BUILTIN.libarchive?=	no
.if ${CHECK_BUILTIN.libarchive:tl} == no
.  if ${USE_BUILTIN.libarchive:tl} == yes

BUILDLINK_TARGETS+=	fake-libarchive-pc

_FAKE_LIBARCHIVE_PC=	${BUILDLINK_DIR}/lib/pkgconfig/libarchive.pc
_LIBARCHIVE_LIBS=	-llzma -lbz2 -lz

.PHONY: fake-libarchive-pc
fake-libarchive-pc:
	${RUN}  \
	sedsrc=../../archivers/libarchive/files/build/pkgconfig/libarchive.pc.in;	\
	src=${BUILDLINK_PREFIX.libarchive}/lib${LIBABISUFFIX}/pkgconfig/libarchive.pc;	\
	dst=${_FAKE_LIBARCHIVE_PC};				  			\
	${MKDIR} ${BUILDLINK_DIR}/lib/pkgconfig;					\
	if [ ! -f $${dst} ]; then       						\
		if [ -f $${src} ]; then 						\
			${ECHO_BUILDLINK_MSG} "Symlinking $${src}";     		\
			${LN} -sf $${src} $${dst};					\
		else									\
			${ECHO_BUILDLINK_MSG} "Creating $${dst}";			\
			${SED}  -e s,@prefix@,${BUILDLINK_PREFIX.libarchive},		\
					-e s,@exec_prefix@,${BUILDLINK_PREFIX.libarchive},\
					-e s,@libdir@,${BUILDLINK_PREFIX.libarchive}/lib${LIBABISUFFIX},\
					-e s,@includedir@,${BUILDLINK_PREFIX.libarchive}/include,\
					-e s,@VERSION@,${BUILTIN_VERSION.libarchive},	\
					-e s,@LIBS@,${_LIBARCHIVE_LIBS:Q},		\
					-e s,@LIBSREQUIRED@,,				\
				$${sedsrc} > $${dst};					\
		fi									\
	fi
.  endif
.endif
