# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"
inherit cmake-utils git-r3

DESCRIPTION="An open-source car navigation system with a routing engine"
HOMEPAGE="http://www.navit-project.org"

LICENSE="LGPL-2"
SLOT="0"
IUSE="dbus demo espeak garmin gps gtk maptool nls opengl png python sdl speechd svg zlib"

RDEPEND="dev-libs/glib:2
	dbus? ( sys-apps/dbus )
	espeak? ( app-accessibility/espeak )
	garmin? ( dev-libs/libgarmin )
	gps? ( sci-geosciences/gpsd )
	gtk? ( x11-libs/gtk+:2
		x11-misc/xkbd )
	nls? ( sys-devel/gettext )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )
	python? ( dev-lang/python )
	sdl? ( media-libs/libsdl
		media-libs/sdl-image
		dev-games/cegui
		media-libs/quesoglc )
	speechd? ( app-accessibility/speech-dispatcher )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-vcs/cvs
	svg? ( || ( gnome-base/librsvg media-gfx/imagemagick[png,svg] ) )"

EGIT_REPO_URI="https://github.com/navit-gps/navit"
if [[ ${PV} != "9999" ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64"
fi

PATCHES=( "${FILESDIR}/navit-speech-header-location.patch" )

DOCS=( AUTHORS ChangeLog README )

src_configure() {
	local mycmakeargs=(
		-Dvehicles/gpsd="$(usex gps)"
		-Dmap/garmin="$(usex garmin)"
		-Dgui/gtk="$(usex gtk)"
		-Dgraphics/gtk_drawing_area="$(usex gtk)"
		-Dgraphics/sdl="$(usex sdl)"
		-Dgraphics/opengl="$(usex opengl)"
		-Dgui/internal="$(usex sdl)"
		-DUSE_NATIVE_LANGUAGE_SUPPORT="$(usex nls)"
		-Dsupport/gettext_intl="$(usex nls)"
		-Dsupport/libpng="$(usex png)"
		-Dsupport/zlib="$(usex zlib)"
		-DDBUS_USE_SYSTEM_BUS="$(usex dbus)"
		-Dbinding/dbus="$(usex dbus)"
		-Dbinding/python="$(usex python)"
		-DUSE_SVG="$(usex svg)"
		-DSVG2PNG="$(usex svg)"
		-Dspeech/espeak="$(usex espeak)"
		-Dsupport/espeak="$(usex espeak)"
		-Dspeech/speech_dispatcher="$(usex speechd)"
		-DBUILD_MAPTOOL="$(usex maptool)"
		-Dvehicle/demo="$(usex demo)"
		-Dgraphics/qt_qpainter="no"
		-Dgui/qml="no"
		-DSAMPLE_MAP="no"
	)
	if use dbus; then
		mycmakeargs+="-Dspeech/dbus=\"$(usex speechd)\""
		mycmakeargs+="-Dvehicles/gpsd_dbus=\"$(usex gps)\""
	fi
	if use speechd; then
		mycmakeargs+="-DEXTRA_INCLUDES=\"/usr/include/speech-dispatcher/\""
	fi
	cmake-utils_src_configure
}
