# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $id$

EAPI=6

inherit eutils fdo-mime versionator

MY_PV1=$(get_major_version)
MY_PV2=$(get_version_component_range 1-2)

DESCRIPTION="A free PDF document viewer, featuring small size, quick startup, and fast page rendering"
HOMEPAGE="https://www.foxitsoftware.cn/downloads/"
SRC_URI="http://cdn07.foxitsoftware.cn/pub/foxit/reader/desktop/linux/2.x/2.3/en_us/FoxitReader${PV}_Server_x64_enu_Setup.run.tar.gz"

LICENSE="${PN}"
SLOT="0"
KEYWORDS="amd64 -*"
IUSE=""
MY_LANGS="de fr ja zh_CN zh_TW"
for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
done

DEPEND="dev-qt/qt-installer-framework
	app-arch/p7zip"

RDEPEND="
	dev-libs/atk
		dev-libs/glib:2
		media-libs/freetype:2
		net-print/cups
		x11-libs/cairo
		x11-libs/gtk+:2
		x11-libs/pango
"

#S=${WORKDIR}/${MY_PV2}-release
S=${WORKDIR}/${PN}-installer

QA_PRESTRIPPED="/opt/FoxitReader/FoxitReader"
PREV="r242174"
RUN_FILE="FoxitReader.enu.setup.${PV}(${PREV}).x64.run"

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	devtool --dump "${PN}-installer" ${RUN_FILE}
	cd ${S}
	mkdir ${PN}
	cd metadata/"Install Foxit Reader"
	for file in *.7z
	do
		7z x -o"${S}/${PN}" ${file} > /dev/null
	done
}

src_prepare() {
	cd ${S}
	sed -i "/Icon/a Exec=${PN} %U" ${PN}/FoxitReader.desktop

	cd ${PN}
	rm -r welcome/images/.svn stamps/Standard\ Templates/.svn stamps/en-US/Sign\ Here/.svn stamps/en-US/Standard\ Stamps/.svn stamps/en-US/Dynamic\ Stamps/.svn stamps/en-US/.svn
	
	default_src_prepare
}

src_install() {
	insinto /opt/
	doins -r ${PN}
	insinto /usr/share/applications/
	doins ${PN}/FoxitReader.desktop

	fperms 755 /opt/${PN}/FoxitReader 
	make_wrapper ${PN} ./FoxitReader /opt/${PN}
	doicon ${PN}/images/FoxitReader.png || die

}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
