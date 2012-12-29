# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit versionator eutils

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_$(get_version_component_range \
	        1)+git$(get_version_component_range 2).tar.gz"

DESCRIPTION="Deepin Media Player."
HOMEPAGE="https://github.com/linuxdeepin/deepin-media-player"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/deepin-ui-1.201209101328
	sci-libs/scipy
	dev-python/formencode
	media-video/mplayer2"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${PN}-$(get_version_component_range \
	1)+git$(get_version_component_range 2)
src_prepare() {
	rm -rf debian || die
	rm locale/*.po* 
	wget https://gitcafe.com/zhtengw/SlackBuilds/raw/master/deepin-media-player/deepin-media-player.png 
}

src_install() {
	dodoc AUTHORS ChangeLog 

	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/app_theme ${S}/skin
	fperms 0755 -R /usr/share/${PN}/src/

	dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}

	doicon -s 128 ${PN}.png

	mkdir -p ${D}/usr/share/applications
	cat > ${D}/usr/share/applications/${PN}.desktop <<EOF
[Desktop Entry]
Name=Deepin Media Player
Name[zh_CN]=深度影音播放器
Comment=Play your video collection
Comment[zh_CN]=为您播放本地及网络视频
GenericName=Media Player
Exec=deepin-media-player %U
Icon=deepin-media-player
Type=Application
Categories=AudioVideo;Player;GTK;
MimeType=audio/ac3;audio/mp4;audio/mpeg;audio/vnd.rn-realaudio;audio/vorbis;audio/x-adpcm;audio/x-matroska;audio/x-mp2;audio/x-mp3;audio/x-ms-wma;audio/x-vorbis;audio/x-wav;audio/mpegurl;audio/x-mpegurl;audio/x-pn-realaudio;audio/x-scpls;video/avi;video/mp4;video/flv;video/mpeg;video/quicktime;video/vnd.rn-realvideo;video/x-matroska;video/x-ms-asf;video/x-msvideo;video/x-ms-wmv;video/x-ogm;video/x-theora;
EOF
}

