# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_VENDOR=( 
	"github.com/armon/go-socks5				e753329" 
	"github.com/davecgh/go-spew				v1.1.0"
	"github.com/fatedier/beego				6c6a4f5"
	"github.com/fatedier/golib				ff8cd81"
	"github.com/fatedier/kcp-go				2063a80"
	"github.com/golang/snappy				553a641"
	"github.com/gorilla/context				v1.1.1"
	"github.com/gorilla/mux					v1.6.2"
	"github.com/gorilla/websocket			v1.2.0"
	"github.com/hashicorp/yamux				2f1d1f2"
	"github.com/inconshreveable/mousetrap	v1.0.0"
	"github.com/klauspost/cpuid				v1.2.0"
	"github.com/klauspost/reedsolomon		v1.9.1"
	"github.com/mattn/go-runewidth			v0.0.4"
	"github.com/pires/go-proxyproto			4d51b51"
	"github.com/pkg/errors					v0.8.0"
	"github.com/pmezard/go-difflib			v1.0.0"
	"github.com/rakyll/statik				v0.1.1"
	"github.com/rodaine/table				v1.0.0"
	"github.com/spf13/cobra					v0.0.3"
	"github.com/spf13/pflag					v1.0.1"
	"github.com/stretchr/testify			v1.2.1"
	"github.com/templexxx/cpufeat			3794dfb"
	"github.com/templexxx/xor				0af8e87"
	"github.com/tjfoc/gmsm					98aa888"
	"github.com/vaughan0/go-ini				a98ad7e"
	"golang.org/x/crypto					4ec37c6	github.com/golang/crypto"
	"golang.org/x/net						dfa909b	github.com/golang/net"
	)

inherit systemd golang-vcs-snapshot

EGO_PN="github.com/fatedier/frp"
#GIT_COMMIT="456f5476cf9bf96c558448372058130fee1f9330"
ARCHIVE_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="A fast reverse proxy"
HOMEPAGE="https://github.com/fatedier/frp"
SRC_URI="${ARCHIVE_URI}
	${EGO_VENDOR_URI}"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RESTRICT="test"

DEPEND=">=dev-lang/go-1.12"

src_compile() {
	for x in frpc frps; do
		GOPATH="${S}" go build -v -work -x -ldflags "-X main.VERSION=${PV} -s -w" \
			-o "bin/${x}" "${EGO_PN}/cmd/${x}" || die
	done
}

src_install() {
	dobin bin/frpc bin/frps

	insinto /etc/frp
	doins src/${EGO_PN}/conf/{frpc,frpc_full,frps,frps_full}.ini

	newinitd "${FILESDIR}/frps.initd" frps
	newinitd "${FILESDIR}/frpc.initd" frpc

	systemd_dounit src/${EGO_PN}/conf/systemd/frps.service
	systemd_dounit src/${EGO_PN}/conf/systemd/frpc.service

}
