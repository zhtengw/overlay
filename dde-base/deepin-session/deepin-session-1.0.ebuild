# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

DESCRIPTION="Deepin Desktop Session"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="gnome-base/gnome-settings-daemon
		gnome-base/gnome-session"
DEPEND=""

src_install() {

	insinto "/etc/xdg/autostart"
	doins ${S}/debian/gnome-settings-daemon-deepin.desktop

	insinto "/usr/share/gnome-session/sessions"
	doins ${S}/debian/deepin.session

	insinto "/usr/share/xsessions"
	doins ${S}/debian/deepin.desktop

}

