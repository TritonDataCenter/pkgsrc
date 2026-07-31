IPS_PKGNAME?=		${CATEGORIES:[1]}/${PKGBASE}

_IPS_SHAREDIR=		${PKGSRCDIR}/mk/pkgformat/ips
_IPS_DIR=		${WRKDIR}/.ips
_IPS_VARS=		${_IPS_DIR}/vars
_IPS_PREFIX=		${PREFIX:C,^/,,}

_IPS_VARS_DEPS=		${_DEPENDS_FILE} ${_RDEPENDS_FILE} ${PLIST}
_IPS_VARS_DEPS+=	${_DESCR_FILE}

${_IPS_VARS}: ${_IPS_VARS_DEPS}
	${RUN}${TEST} -d ${.TARGET:H} || ${MKDIR} ${.TARGET:H}
	${RUN}: > ${.TARGET}
	${RUN}{								\
		${ECHO} "SET ipsname ${IPS_PKGNAME}";			\
		${ECHO} "SET ipspublisher ${IPS_PUBLISHER}";		\
		${ECHO} "SET ipsbranch ${IPS_BRANCH}";			\
		${ECHO} "SET ipsbuildrelease ${IPS_BUILD_RELEASE}";	\
		${ECHO} "SET ipsrepo ${IPS_REPO}";			\
		${ECHO} "SET pkgname ${PKGNAME}";			\
		${ECHO} "SET pkgversion ${PKGVERSION}";			\
		${ECHO} "SET pkgpath ${PKGPATH}";			\
		${ECHO} "SET prefix ${_IPS_PREFIX}";			\
		${ECHO} "SET pkgmandir ${PKGMANDIR}";			\
		${ECHO} "SET destdir ${DESTDIR}";			\
		${ECHO} "SET plist ${PLIST}";				\
		${ECHO} "SET descr ${_DESCR_FILE}";			\
		${ECHO} "SET summary "${COMMENT:Q};			\
		${ECHO} "SET homepage ${HOMEPAGE:U}";			\
		${ECHO} "SET options ${PKG_OPTIONS:U}";			\
		${ECHO} "SET license ${LICENSE:U}";			\
		${ECHO} "USERS ${PKG_USERS:U}";				\
		${ECHO} "GROUPS ${PKG_GROUPS:U}";			\
		${ECHO} "DIRS ${OWN_DIRS:U} ${MAKE_DIRS:U} ${REQD_DIRS:U}"; \
		${ECHO} "DIRPERMS ${OWN_DIRS_PERMS:U} ${MAKE_DIRS_PERMS:U} ${REQD_DIRS_PERMS:U}"; \
		${ECHO} "CONF ${CONF_FILES:U}";				\
		${ECHO} "CONFPERMS ${CONF_FILES_PERMS:U}";		\
		${ECHO} "REQD ${REQD_FILES:U}";				\
		${ECHO} "REQDPERMS ${REQD_FILES_PERMS:U}";		\
		${ECHO} "PERMS ${SPECIAL_PERMS:U}";			\
		${ECHO} "CONFMODE ${CONF_FILES_MODE:U0644}";		\
		${ECHO} "REQDMODE ${REQD_FILES_MODE:U0644}";		\
	} >> ${.TARGET}
.for _ipsu_ in ${PKG_USERS}
.  for e in ${_ipsu_:C/\:.*//}
	${RUN}{								\
		${ECHO} "UID ${e} ${PKG_UID.${e}:U}";			\
		${ECHO} "HOME ${e} ${PKG_HOME.${e}:U}";			\
		${ECHO} "SHELL ${e} ${PKG_SHELL.${e}:U}";		\
		${ECHO} "GECOS ${e} "${PKG_GECOS.${e}:U:Q};		\
	} >> ${.TARGET}
.  endfor
.endfor
.for _ipsg_ in ${PKG_GROUPS}
	${RUN}${ECHO} "GID ${_ipsg_} ${PKG_GID.${_ipsg_}:U}" >> ${.TARGET}
.endfor
.if defined(SMF_MANIFEST_FILE)
	${RUN}${ECHO} "SMF ${SMF_MANIFEST_FILE}" >> ${.TARGET}
.endif
	${RUN}${AWK} -f ${_IPS_SHAREDIR}/depends.awk			\
		${_DEPENDS_FILE} ${_RDEPENDS_FILE} >> ${.TARGET}

.PHONY: ips-publish
ips-publish: ${STAGE_PKGFILE} ${_IPS_VARS}
	@${PHASE_MSG} "Publishing IPS package of "${PKGNAME:Q}
	${RUN}${PKGSRC_SETENV}						\
		AWK=${AWK:Q}						\
		PKGSEND=${PKGSEND:Q} PKGMOGRIFY=${PKGMOGRIFY:Q}		\
		PKGFMT=${PKGFMT:Q} PKGREPO=${PKGREPO:Q}			\
		IPS_SHAREDIR=${_IPS_SHAREDIR:Q}				\
		IPS_LOCAL_MOG=${IPS_LOCAL_MOG:Q}			\
		${SH} ${_IPS_SHAREDIR}/generate ${_IPS_VARS} ${_IPS_DIR}

package-create: ips-publish
