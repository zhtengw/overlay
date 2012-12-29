# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit eutils versionator

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_$(get_version_component_range 1-2)+git$(get_version_component_range 3).orig.tar.gz"

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-screenshot"

LICENSE="LGPL-3"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/deepin-ui-1.201209291421
	dev-python/pywebkitgtk
	dev-python/libwnck-python
	dev-python/pyxdg
	dev-python/pycurl
	dev-python/python-xlib"
DEPEND="dev-python/epydoc"
S=${WORKDIR}
src_prepare() {
	rm -rf debian || die
	rm locale/*.po* 
}

src_install() {
	dodoc AUTHORS ChangeLog README

	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/theme ${S}/skin
	fperms 0755 -R /usr/share/${PN}/src/

	dosym /usr/share/${PN}/src/${PN} /usr/bin/${PN}

	dodir /usr/share/applications
	cat > ${ED}/usr/share/applications/${PN}.desktop <<EOF
[Desktop Entry]
Hidden=false
Exec=${PN}
Name=${PN}
Name[zh_CN]=深度截屏工具
Type=Application
NoDisplay=false
StartupNotify=false
Icon=/usr/share/${PN}/theme/logo/${PN}.png
Terminal=false
Categories=GTK;GNOME;Utility;
EOF
}

