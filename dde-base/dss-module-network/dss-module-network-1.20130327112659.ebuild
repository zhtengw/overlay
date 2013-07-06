# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils

DSS="deepin-system-settings"
MY_VER=$(get_version_component_range 1)+git$(get_version_component_range 2)
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${DSS}/${DSS}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin System Settings module for configuring network"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pptp l2tp +modem"
RDEPEND="dde-base/deepin-system-settings
		dev-python/python-gudev
		dev-python/keyring
		net-libs/glib-networking
		net-misc/networkmanager
		dev-python/pytz
		pptp? ( net-misc/networkmanager-pptp )
		l2tp? ( net-misc/networkmanager-l2tp )
		modem? ( net-misc/modemmanager )"
DEPEND=""
S="${WORKDIR}/${DSS}-${MY_VER}/modules/network"

src_install() {
	
	insinto "/usr/share/${DSS}/modules/network"
	doins -r ${S}/src ${S}/locale ${S}/__init__.py ${S}/config.ini

	rm ${D}/usr/share/${DSS}/modules/network/locale/*.po*
	fperms 0755 -R /usr/share/${DSS}/modules/network/src/main.py

}
