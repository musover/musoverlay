# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="1"

inherit kernel-2
detect_version
detect_arch

UNIPATCH_LIST="${FILESDIR}/${KV_MAJOR}.${KV_MINOR}/*"

DESCRIPTION="Meoberto's ACS-patched kernel sources for the ${KV_MAJOR}.${KV_MINOR} release"
HOMEPAGE="http://www.mthree.es"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

KEYWORDS="~amd64 ~x86"
IUSE="experimental"

DEPEND=">=sys-devel/gcc-4.5"
RDEPEND="${DEPEND}"

pkg_postinst(){
	kernel-2_pkg_postinst

	einfo
	einfo "To activate ACS override functionality, some parameters must be added to the kernel cmdline."
	einfo "pci_acs_override ="
	einfo "				[PCIE] Override missing PCIe ACS support for:"
	einfo "			downstream"
	einfo "				All downstream ports - full ACS capabilities"
	einfo "			multfunction"
	einfo "				All multifunction devices - multifunction ACS subset"
	einfo "			id:nnnn:nnnn"
	einfo "				Specfic device - full ACS capabilities"
	einfo "				Specified as vid:did (vendor/device ID) in hex"
}
