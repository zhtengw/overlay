# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit unpacker

DESCRIPTION="Fcitx Wrapper for sogoupinyin."
HOMEPAGE="http://code.google.com/p/fcitx"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/f/${PN}-release/${PN}-release_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.6"
DEPEND="${RDEPEND}
	dev-util/intltool"
	
S=${WORKDIR}/${PN}-release-${PV}/arch

src_install(){
	if use x86 ;then 
		ARCHIVE="${S}/data.i386.tar.xz"
		LIBDIR="/usr/lib/i386-linux-gnu"
	elif use amd64 ;then 
		ARCHIVE="${S}/data.amd64.tar.xz"
		LIBDIR="/usr/lib/x86_64-linux-gnu"
	fi
	unpacker ${ARCHIVE}
	
	insinto /usr/lib/fcitx
	doins ${S}/${LIBDIR}/fcitx/${PN}.so
	fperms 0755 /usr/lib/fcitx/${PN}.so
	
	insinto /usr/share
	doins -r ${S}/usr/share/icons ${S}/usr/share/fcitx ${S}/usr/share/locale
}