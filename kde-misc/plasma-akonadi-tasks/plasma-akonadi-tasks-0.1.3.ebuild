# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

SRC_URI="http://kde-apps.org/CONTENT/content-files/149525-akonadi-tasks-${PV}.tar.bz2"
DESCRIPTION="This is a plasmoid for displaying your tasks from Akonadi. 
	    You can also add new tasks or edit your existing tasks. "
HOMEPAGE="http://www.kde-look.org"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep kdelibs)
	$(add_kdebase_dep kdepimlibs)
	app-office/akonadi-server
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-runtime)
" 
S=${WORKDIR}/akonadi-tasks-${PV}