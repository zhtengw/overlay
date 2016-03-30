# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_REQ_USE='sqlite'
PYTHON_COMPAT=( python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Qnotero provides lightning quick access to your Zotero references."
HOMEPAGE="http://www.cogsci.nl/software/qnotero https://github.com/smathot/qnotero"
SRC_URI="https://github.com/smathot/${PN}/archive/release/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/PyQt4"
RDEPEND="${DEPEND}
		sci-misc/Zotero"

S="${WORKDIR}/${PN}-release-${PV}"
