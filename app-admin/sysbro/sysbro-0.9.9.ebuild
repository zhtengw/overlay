# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="A System Assistant for Deepin"
HOMEPAGE="https://sysbro-linux.github.io/"
SRC_URI="https://github.com/rekols/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/systemd
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
		dev-qt/qtnetwork:5
		sys-apps/lm-sensors
		>=dde-base/dtkwidget-2.0.9.5:2
		dde-base/dtkcore:2
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"

src_prepare() {
	sed -i "s|dtkwidget|dtkwidget2|g" \
		src/src.pro \
		file-shredder/file-shredder.pro \
		network-test/network-test.pro \
		startup-apps/startup-apps.pro || die

	QT_SELECT=qt5 eqmake5 ${PN}.pro PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
