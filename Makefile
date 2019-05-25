include /usr/share/dpkg/pkg-info.mk

export KERNEL_VER=5.0
export KERNEL_ABI=5.0.8-2-pve

PACKAGE=pve-kernel-${KERNEL_VER}

GITVERSION:=$(shell git rev-parse HEAD)

KERNEL_DEB=pve-kernel-${KERNEL_VER}_${DEB_VERSION_UPSTREAM_REVISION}_all.deb
HEADERS_DEB=pve-headers-${KERNEL_VER}_${DEB_VERSION_UPSTREAM_REVISION}_all.deb

BUILD_DIR=build

DEBS=${KERNEL_DEB} ${HEADERS_DEB}

all: deb
deb: ${DEBS}

${HEADERS_DEB}: ${KERNEL_DEB}
${KERNEL_DEB}: debian
	rm -rf ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}/debian
	cp -ar debian/* ${BUILD_DIR}/debian/
	cd ${BUILD_DIR}; debian/rules debian/control
	echo "git clone git://git.proxmox.com/git/pve-kernel-meta.git\\ngit checkout ${GITVERSION}" > ${BUILD_DIR}/debian/SOURCE
	cd ${BUILD_DIR}; dpkg-buildpackage -b -uc -us
	lintian ${KERNEL_DEB} ${HEADERS_DEB}

.PHONY: upload
upload: ${DEBS}
	tar cf - ${DEBS}|ssh repoman@repo.proxmox.com -- upload --product pve,pmg --dist buster

.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *~ ${BUILD_DIR} *.deb *.dsc *.changes *.buildinfo
