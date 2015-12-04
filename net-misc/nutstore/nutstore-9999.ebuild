# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="坚果云( Nutstore Cloud Storage )"
HOMEPAGE="http://www.jianguoyun.com"
SRC_URI=""

LICENSE="nutstore"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre
 		dev-python/notify-python
 		gnome-base/gvfs"

src_install() {
	dobin ${FILESDIR}/nutstore_init
}

pkg_postinst() {
	elog
	elog "Any runtime applications will install into USER's \$HOME directory."
	elog "Please run nutstore_init in the terminal for all the USERs in system"
	elog  "to initial the applications."
	elog

}

pkg_postrm() {
	elog
	elog "You should remove the directory and files list below manually for all USERs:"
	elog "\$HOME/.nutstore"
	elog "\$HOME/.local/share/applications/nutstore-menu.desktop"
	elog "\$HOME/.local/share/icons/hicolor/64x64/apps/nutstore.png"
	elog "\$HOME/.config/autostart/nutstore-daemon.desktop"
	elog

}