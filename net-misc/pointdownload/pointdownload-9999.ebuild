# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh/libssh-9999.ebuild,v 1.5 2011/05/03 11:32:59 scarabeus Exp $

# Maintainer: check IUSE-defaults at DefineOptions.cmake

EAPI=7

EGIT_REPO_URI="https://github.com/PointTeam/PointDownload.git"
EGIT_BRANCH="develop"

inherit qmake-utils git-2

DESCRIPTION="Efficient and easy to use downloading tools for Http,Https,Ftp, P2P(BT、magnet、ed2k、thunder etc.) protocols"
HOMEPAGE="https://github.com/PointTeam/PointDownload"

LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND="x11-libs/libX11
	      x11-libs/libXtst
	      >=dev-qt/qtcore-5.2.1:5
	      dev-qt/qtdeclarative:5
	      dev-qt/qtwebkit:5
	      dev-qt/qtmultimedia:5
	      dev-qt/qtopengl:5
	      "
RDEPEND="${DEPEND}
	      dev-qt/qtgui:5
	      dev-qt/qtxml:5
	      dev-qt/qtwidgets:5
	      dev-qt/qtnetwork:5
	      "

#DOCS=( AUTHORS README ChangeLog )

src_prepare() {
	sed -i 's/FileFox/FireFox/g' ${S}/${PN}.pro || die "configure failed"
# 	sed -i 's/opt\/Point/usr\/share/g' ${S}/*.desktop || die "configure failed"
	
# 	eqmake5 PREFIX=/usr/share 
	eqmake5
	default
}
src_install() {
 	INSTALL_ROOT=${D} emake install || die "emake install failed"
 	
 	rm -r ${D}/opt/PointDownload
 	
 	insinto /usr/share/applications
 	doins ${S}/${PN}.desktop ${S}/pointpopup.desktop
 	
 	insinto /usr/bin
 	dosym /opt/Point/PointDownload/PointDownload /usr/bin/pointdownload
 	dosym /opt/Point/PointDownload/XwareStartUp /usr/bin/pointxware
 	dosym /opt/Point/PopupWindow/PointPopup  /usr/bin/pointpopup
 	
}
