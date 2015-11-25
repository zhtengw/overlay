# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

DESCRIPTION="MathType's fonts for MathType equations."
HOMEPAGE="http://www.dessci.com/en/dl/fonts/"

SRC_URI="
		http://www.dessci.com/en/dl/DS_Fonts_${PV}_(TT).exe
		http://www.dessci.com/en/dl/DS_Fonts_${PV}_(PS).exe"

LICENSE="DSFLA"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd     ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~    sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="app-arch/cabextract"

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf afm pfb pfm"

src_unpack() {
	for exe in ${A} ; do
		echo ">>> Unpacking ${exe} to ${WORKDIR}"
		cabextract --lowercase "${DISTDIR}"/${exe} > /dev/null \
		|| die "failed to unpack ${exe}"
	done

}

