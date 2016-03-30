# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils

DESCRIPTION="Zotero [zoh-TAIR-oh] is a free, easy-to-use tool to help you collect, organize, cite, and share your research sources."
HOMEPAGE="https://www.zotero.org/"
SRC_URI="amd64? ( https://download.zotero.org/standalone/${PV}/Zotero-${PV}_linux-x86_64.tar.bz2 ) 
		x86? ( https://download.zotero.org/standalone/${PV}/Zotero-${PV}_linux-i686.tar.bz2 ) "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

RDEPEND="dev-libs/dbus-glib
		x11-libs/gtk+:2
		dev-libs/nss"


if use amd64; then 
	S=${WORKDIR}/${PN}_linux-x86_64
elif use x86; then
	S=${WORKDIR}/${PN}_linux-i686
fi

src_prepare() {
	sed -i -e "s|MOZ_PROGRAM=\"\"|MOZ_PROGRAM=\"/opt/${PN}/zotero\"|g" ${S}/run-zotero.sh
}

src_install() {

	# install zotero files to /opt/Zotero
	insinto /opt/${PN}
	doins -r ${S}/* || die "Installing files failed"

	newicon -s 16 chrome/icons/default/default16.png zotero.png
	newicon -s 32 chrome/icons/default/default32.png zotero.png
	newicon -s 48 chrome/icons/default/default48.png zotero.png
	
# 	dodir /usr/share/applications/
#	echo "[Desktop Entry]
# 	Name=Zotero
# 	Comment=Open-source reference manager (standalone version)
# 	Exec=/usr/bin/zotero %f
# 	Icon=zotero
# 	Type=Application
# 	StartupNotify=true
# 	Categories=Office;Education;Science;" > ${D}/usr/share/applications/${PN}.desktop
	domenu ${FILESDIR}/${PN}.desktop
	
	# make zotero executable
	fperms +x /opt/${PN}/zotero /opt/${PN}/run-zotero.sh
	
	dosym /opt/${PN}/run-zotero.sh /usr/bin/zotero


}

