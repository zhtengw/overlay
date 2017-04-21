# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="The Qt Installer Framework used for the Qt SDK installer."
HOMEPAGE="http://qt-project.org/wiki/Qt-Installer-Framework"
MY_P="${PN}-opensource-${PV}-src"
SRC_URI="https://download.qt.io/official_releases/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

# minimum Qt version required
QT_PV="5.5.0:5"

RDEPEND=">=dev-qt/qtcore-${QT_PV}
		 >=dev-qt/qtdeclarative-${QT_PV}
	     "
DEPEND="${RDEPEND}
		dev-qt/designer
		doc? ( >=dev-qt/qdoc-${QT_PV} )
		test? ( >=dev-qt/qttest-${QT_PV} )
	     "

S=${WORKDIR}/${MY_P}

src_prepare() {
	eqmake5	$(use test && echo BUILD_TESTS=1) ./installerfw.pro
}

src_install() {
		dobin bin/*
		dolib lib/libinstaller*
		if use doc; then
			emake docs
			insinto /usr/share/doc/qt-installer-framework
			doins -r doc/ifw.qch doc/html
		fi
}
