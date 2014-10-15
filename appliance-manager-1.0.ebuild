# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

SLOT="0"

CROS_WORKON_PROJECT="jonfk/appliance-management-web"
CROS_WORKON_LOCALNAME="appliance-management-web"
CROS_WORKON_REPO="git://github.com"

DESCRIPTION="appliance-manager"
HOMEPAGE="https://github.com/jonfk/appliance-management-web"
SRC_URI=""

inherit toolchain-funcs cros-workon systemd

LICENSE="MIT"

if [[ "${PV}" == 9999 ]]; then
    KEYWORDS="~amd64"
else
    #CROS_WORKON_COMMIT="49e0dff2b8529801beb09164729caf96a5b93ef0" # v0.4.6
    KEYWORDS="amd64"
fi

DEPEND=">=dev-lang/go-1.2"

src_compile() {
	./build
}

src_install() {
	dobin ${S}/bin/${PN}

	insinto /usr/share/appliance-manager/templates/
	doins templates/*

	systemd_dounit "${FILESDIR}"/${PN}.service
}