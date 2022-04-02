# Distributed under the terms of the GNU General Public License v2
# RESTRICT="mirror" is used because modprobed-db is not in any mirrors
EAPI="7"
inherit git-r3

DESCRIPTION="Keeps a running list of ALL modules ever probed on a system and allows for easy recall on demand."
HOMEPAGE="https://github.com/graysky2/modprobed-db"
EGIT_REPO_URI="https://github.com/graysky2/modprobed-db"
EGIT_COMMIT="v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/kmod"
