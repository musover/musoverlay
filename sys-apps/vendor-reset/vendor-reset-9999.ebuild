# Distributed under the terms of the GNU General Public License v2
EAPI="7"
inherit git-r3 linux-mod linux-info

DESCRIPTION="Keeps a running list of ALL modules ever probed on a system and allows for easy recall on demand."
HOMEPAGE="https://github.com/gnif/vendor-reset"
EGIT_REPO_URI="https://github.com/gnif/vendor-reset"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}"
CONFIG_CHECK="
	FTRACE
	KPROBES
	PCI_QUIRKS
	KALLSYMS
	KALLSYMS_ALL
	FUNCTION_TRACER
"

MODULE_NAMES="vendor-reset"
