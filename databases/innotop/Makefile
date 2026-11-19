# $NetBSD: Makefile,v 1.16 2026/07/16 19:01:33 wiz Exp $
#

DISTNAME=	innotop-1.9.1
PKGREVISION=	12
CATEGORIES=	databases
MASTER_SITES=	http://innotop.googlecode.com/files/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/innotop/innotop
COMMENT=	MySQL and InnoDB monitor program
LICENSE=	gnu-gpl-v2

DEPENDS+=	p5-Term-ReadKey>=2.10:../../devel/p5-Term-ReadKey
DEPENDS+=	p5-DBI>=1.13:../../databases/p5-DBI

PERL5_PACKLIST=	auto/innotop/.packlist
REPLACE_PERL=	innotop
NO_BUILD=	YES

.include "../../databases/p5-DBD-mysql/dependency.mk"
.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
