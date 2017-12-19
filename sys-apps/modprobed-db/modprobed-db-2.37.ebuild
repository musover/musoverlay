# Distributed under the terms of the GNU General Public License v2
# RESTRICT="mirror" is used because modprobed-db is not in any mirrors
EAPI="5"

DESCRIPTION="Keeps a running list of ALL modules ever probed on a system and allows for easy recall on demand."
HOMEPAGE="https://wiki.archlinux.org/index.php/Modprobed-db"
SRC_URI="http://repo-ck.com/source/${PN}/${PN}-${PV}.tar.xz"

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/kmod"
