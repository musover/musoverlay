# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="14"
K_EXP_GENPATCHES_PULL="1"
K_EXP_GENPATCHES_NOUSE="1"

inherit kernel-2
detect_version
detect_arch

CK_VERSION="1"
K_BRANCH="${KV_MAJOR}.${KV_MINOR}"
CK_URI="http://ck.kolivas.org/patches/4.0/${K_BRANCH}/${K_BRANCH}-ck${CK_VERSION}/patch-${K_BRANCH}-ck${CK_VERSION}.xz"

DESCRIPTION="Meoberto's ACS-patched kernel sources for the ${KV_MAJOR}.${KV_MINOR} release"
HOMEPAGE="http://www.mthree.es"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_URI}"

UNIPATCH_LIST="${DISTDIR}/patch-${K_BRANCH}-ck${CK_VERSION}.xz ${FILESDIR}/${K_BRANCH}/*"
UNIPATCH_STRICTORDER="yes"
K_EXP_GENPATCHES_LIST="5010_*.patch*"

KEYWORDS="~amd64 ~x86"
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
