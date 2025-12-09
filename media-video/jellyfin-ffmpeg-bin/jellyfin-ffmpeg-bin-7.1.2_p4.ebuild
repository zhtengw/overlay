# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FFmpeg for Jellyfin with custom extensions and enhancements"
HOMEPAGE="https://github.com/jellyfin/jellyfin-ffmpeg"

LICENSE="GPL-2.0+"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~arm64"

VER="$(ver_cut 1-3)"
MAJOR_VER=$(ver_cut 1)
PATCH_VER=$(ver_cut 5)
MY_PV="${VER}-${PATCH_VER}"

SRC_URI="
        arm64? (
            https://repo.jellyfin.org/files/ffmpeg/linux/${MAJOR_VER}.x/${MY_PV}/arm64/jellyfin-ffmpeg_${MY_PV}_portable_linuxarm64-gpl.tar.xz
        )
        amd64? (
            https://repo.jellyfin.org/files/ffmpeg/linux/${MAJOR_VER}.x/${MY_PV}/amd64/jellyfin-ffmpeg_${MY_PV}_portable_linux64-gpl.tar.xz
        )"

S="${WORKDIR}"

src_install() {
    # Install WITHOUT overwriting system ffmpeg/ffprobe:
    # install as jellyfin-ffmpeg and jellyfin-ffprobe
    einfo "Installing jellyfin-ffmpeg -> ${bindir}/jellyfin-ffmpeg"
    newbin ffmpeg jellyfin-ffmpeg
    einfo "Installing jellyfin-ffprobe -> ${bindir}/jellyfin-ffprobe"
    newbin ffprobe jellyfin-ffprobe

}

pkg_postinst() {
    einfo "=================================================================="
    einfo "jellyfin-ffmpeg has been installed as:"
    einfo "  /usr/bin/jellyfin-ffmpeg"
    einfo "  /usr/bin/jellyfin-ffprobe"
    einfo ""
    einfo "IMPORTANT:"
    einfo "  This package does NOT replace your system /usr/bin/ffmpeg or /usr/bin/ffprobe."
    einfo "  To use these Jellyfin-provided binaries, open the Jellyfin Admin Dashboard,"
    einfo "  go to Server -> Playback / Transcoding settings, and set the FFmpeg path to:"
    einfo "    /usr/bin/jellyfin-ffmpeg"
    einfo "  (and FFprobe path to /usr/bin/jellyfin-ffprobe if required)."
    einfo ""
    einfo "=================================================================="
}
