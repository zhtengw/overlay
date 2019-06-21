# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd user

DESCRIPTION="The Free Software Media System"
HOMEPAGE="https://github.com/jellyfin/jellyfin"
MY_PN=${PN%-bin}
SRC_URI="amd64? ( https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}_${PV}_linux-amd64.tar.gz -> ${P}.tar.gz )
	amd64? ( https://github.com/jellyfin/jellyfin-ffmpeg/releases/download/v4.0.4-3/jellyfin-ffmpeg_4.0.4-3-bionic_amd64.deb )"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="system-ffmpeg"

DEPEND=""
RDEPEND="${DEPEND}
		system-ffmpeg? ( media-video/ffmpeg[vaapi,x264,x265,webp,bluray,zvbi,mp3,opus,theora] )
		!system-ffmpeg? ( x11-libs/libva:0/2[X,drm]
						media-libs/libbluray
						~media-libs/libwebp-0.6.1
						media-libs/zvbi
						media-sound/lame
						media-libs/opus
						media-libs/libass
						dev-libs/fribidi
						media-libs/libtheora
						media-libs/x264:0/152
						media-libs/x265:0/146
						x11-libs/libvdpau )

		sys-process/at
		dev-db/sqlite:3
		media-libs/fontconfig
		media-libs/freetype
		dev-util/lttng-ust
		app-crypt/mit-krb5
		dev-libs/icu
		dev-libs/openssl"

S=${WORKDIR}/${MY_PN}_${PV}

pkg_setup() {
	enewgroup "${MY_PN}"
	enewuser "${MY_PN}" -1 -1 "/var/lib/${MY_PN}" "${MY_PN}"
	esethome "${MY_PN}" "/var/lib/${MY_PN}"
}

src_unpack() {
	default_src_unpack
	use system-ffmpeg || unpack ${WORKDIR}/data.tar.xz
}

src_install() {

	insinto /
	doins -r ${FILESDIR}/etc
	fowners -R "${MY_PN}:${MY_PN}" "/etc/${MY_PN}"

	sed -i "s|/usr/lib/|/usr/$(get_libdir)/|g" \
		${ED}/etc/default/${MY_PN}
	if use system-ffmpeg; then
		sed -i "s|^JELLYFIN_FFMPEG_OPT=|\#JELLYFIN_FFMPEG_OPT=|g" ${ED}/etc/default/${MY_PN} || die
	else
		exeinto /usr/$(get_libdir)/${MY_PN}-ffmpeg/
		doexe ${WORKDIR}/usr/lib/jellyfin-ffmpeg/{ffmpeg,ffprobe}

		dosym /usr/$(get_libdir)/libwebp.so.7.0.1 /usr/$(get_libdir)/libwebp.so.6
	fi

	keepdir "/var/lib/${MY_PN}"
	fowners -R "${MY_PN}:${MY_PN}" "/var/lib/${MY_PN}"

	keepdir "/var/log/${MY_PN}"
	fowners -R "${MY_PN}:${MY_PN}" "/var/log/${MY_PN}"

	keepdir "/var/cache/${MY_PN}"
	fowners -R "${MY_PN}:${MY_PN}" "/var/cache/${MY_PN}"

	systemd_dounit ${FILESDIR}/${MY_PN}.service

	exeinto /usr/$(get_libdir)/${MY_PN}
	doexe ${FILESDIR}/restart.sh

	insinto /usr/$(get_libdir)/${MY_PN}/bin
	doins -r ${S}/*
	fperms 0755 /usr/$(get_libdir)/${MY_PN}/bin/${MY_PN}

	dosym /usr/$(get_libdir)/${MY_PN}/bin/${MY_PN} /usr/bin/${MY_PN}
}
