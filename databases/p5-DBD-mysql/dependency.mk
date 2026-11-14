# $NetBSD$
#
# Depend on the correct p5-DBD driver based on MySQL selection.
#

.include "../../mk/mysql.buildlink3.mk"

.if ${MYSQL_VERSION:Mmariadb*}
DEPENDS+=	p5-DBD-MariaDB>0:../../databases/p5-DBD-MariaDB
.else
DEPENDS+=	p5-DBD-{mysql,percona}*-[0-9]*:../../databases/p5-DBD-mysql
.endif
