# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit git-2

EGIT_REPO_URI="git://github.com/linuxdeepin/deepin-screenshot.git"

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-screenshot"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/deepin-ui-20120928
	dev-python/pywebkitgtk
	dev-python/libwnck-python
	dev-python/pyxdg
	dev-python/pycurl
	dev-python/python-xlib"
DEPEND="dev-python/epydoc"

src_prepare() {
	chmod u+x tools/*.py || die
	cd tools
	./generate_mo.py || die "failed to update Translate"
	cd ..
	rm -rf debian || die
	rm locale/*.po* 
}

src_install() {
	dodoc AUTHORS ChangeLog README

	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/theme ${S}/skin
	fperms 0755 -R /usr/share/${PN}/src/*.py
	fperms 0755 /usr/share/${PN}/src/${PN}

	dosym /usr/share/${PN}/src/${PN} /usr/bin/${PN}

	mkdir -p ${D}/usr/share/applications
	cat > ${D}/usr/share/applications/${PN}.desktop <<EOF
[Desktop Entry]
Hidden=false
Exec=${PN}
Icon=/usr/share/${PN}/theme/logo/deepin-screenshot.png
Name[zh_CN]=深度截屏工具
Type=Application
NoDisplay=false
StartupNotify=false
Icon[zh_CN]=/usr/share/${PN}/theme/logo/deepin-screenshot.png
Terminal=false
Name=${PN}
Categories=GTK;GNOME;Utility;
EOF
}

