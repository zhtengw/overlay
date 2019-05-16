# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="A System Assistant for Deepin"
HOMEPAGE="https://sysbro-linux.github.io/"
SRC_URI="https://github.com/rekols/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/systemd
		dev-qt/qtsvg:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
		dev-qt/qtnetwork:5
		>=dde-base/dtkwidget-2.0.9.5
		dde-base/dtkcore
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"

