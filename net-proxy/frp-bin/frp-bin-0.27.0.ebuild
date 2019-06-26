# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_PN=${PN%-bin}
inherit systemd

DESCRIPTION="A fast reverse proxy."
HOMEPAGE="https://github.com/fatedier/frp"
COMMON_URI="https://github.com/fatedier/frp/releases/download/v${PV}/${MY_PN}_${PV}_linux_"
SRC_URI="
	amd64?	( ${COMMON_URI}amd64.tar.gz )
	x86?	( ${COMMON_URI}386.tar.gz )
	arm?	( ${COMMON_URI}arm.tar.gz )
	arm64?	( ${COMMON_URI}arm64.tar.gz )
	mips?	( ${COMMON_URI}mips.tar.gz )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~mips"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	fi
	mv * "${PN}"-"${PV}"
}

src_install() {
	cd ${S}
	dobin frpc frps

	insinto /etc/frp
	doins *.ini

	newinitd "${FILESDIR}/frps.initd" frps
	newinitd "${FILESDIR}/frpc.initd" frpc
	systemd_dounit systemd/frps.service
	systemd_dounit systemd/frpc.service
}
