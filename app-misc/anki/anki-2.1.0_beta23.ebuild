# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )
PYTHON_REQ_USE="sqlite"
inherit eutils python-single-r1
DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE=""
SRC_URI="https://apps.ankiweb.net/downloads/beta/anki-2.1.0beta23-source.tgz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
IUSE="latex +recording +sound"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-python/PyQt5-5.9[svg,webengine,network,widgets,gui,webchannel,${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.7.4[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	recording? (
		media-sound/lame
		>=dev-python/pyaudio-0.2.4[${PYTHON_USEDEP}]
	)
	sound? ( media-video/mpv )
	latex? (
		app-text/texlive
		app-text/dvipng
	)"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	sed -i -e "s/updates=True/updates=False/" \
        aqt/profiles.py || die
}

src_configure() {
	true
}

src_compile() {
	${S}/tools/build_ui.sh || die
}

src_install(){
	doicon ${PN}.png
	domenu ${PN}.desktop
	doman ${PN}.1

	dodoc README.md README.development
	python_domodule aqt anki
	python_newscript runanki anki

	python_moduleinto anki
	python_domodule locale
}
