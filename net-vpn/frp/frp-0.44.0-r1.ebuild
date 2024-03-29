# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module systemd

DESCRIPTION="A reverse proxy that exposes a server behind a NAT or firewall to the internet"
HOMEPAGE="https://github.com/fatedier/frp"
SRC_URI="https://github.com/fatedier/frp/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.gentoo.org/~zmedico/dist/frp-0.42.0-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~riscv"
IUSE=""

src_prepare() {
	# patch LDFLAGS to preserve symbol table #792408
	sed -e "s|^\\(LDFLAGS :=\\) -s \\(.*\\)|\1 \2|" -i Makefile || die
	default
}

src_compile() {
	emake all
}

src_install() {
	local x
	dobin bin/{frpc,frps}
	dodoc README*.md
	newinitd "${FILESDIR}/frps.initd" frps
	newinitd "${FILESDIR}/frpc.initd" frpc
	systemd_dounit "${FILESDIR}"/frp{c,s}.service
	systemd_newunit "${FILESDIR}"/frpc_at_.service frpc@.service
	systemd_newunit "${FILESDIR}"/frps_at_.service frps@.service
	insinto /etc/frp
	for x in conf/*.ini; do mv "${x}"{,.example}; done
	doins conf/*.example
}
