# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI="6"

UNIPATCH_STRICTORDER="yes"
UNIPATCH_LIST="${FILESDIR}/acso.patch"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE=0
CKV="${PV/99/}"

ETYPE="sources"

EGIT_BRANCH="${PV/.9999/}/master"
EGIT_REPO_URI="https://github.com/zen-kernel/zen-kernel.git"
inherit kernel-2 git-r3 eutils

detect_version

K_NOSETEXTRAVERSION="don't_set_it"
DESCRIPTION="The Zen Kernel Live Sources"
HOMEPAGE="https://zen-kernel.org"

IUSE=""

KEYWORDS=""

EGIT_CHECKOUT_DIR="${WORKDIR}/linux-${KV_FULL}"

K_EXTRAEINFO="For more info on zen-sources, and for how to report problems, see: \
${HOMEPAGE}, also go to #zen-sources on freenode"

src_prepare(){
	kernel-2_src_prepare
	epatch ${FILESDIR}/${PV/.9999/}/acso.patch
}

pkg_setup(){
	ewarn "Be carefull!! You are about to install live kernel sources."
	ewarn "Git zen-sources are extremely unsupported, even from the upstream"
	ewarn "developers. Use them at your own risk and don't bite us if your"
	ewarn "system explodes"
	kernel-2_pkg_setup
}
