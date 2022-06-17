include /usr/share/dpkg/pkg-info.mk

export KERNEL_VER=5.15
export KERNEL_ABI=5.15.35-3-pve

GITVERSION:=$(shell git rev-parse HEAD)

KERNEL_DEB=pve-kernel-${KERNEL_VER}_${DEB_VERSION_UPSTREAM_REVISION}_all.deb
HEADERS_DEB=pve-headers-${KERNEL_VER}_${DEB_VERSION_UPSTREAM_REVISION}_all.deb
HELPER_DEB=pve-kernel-helper_${DEB_VERSION_UPSTREAM_REVISION}_all.deb

BUILD_DIR=build

DEBS=${KERNEL_DEB} ${HEADERS_DEB} ${HELPER_DEB}

SUBDIRS = proxmox-boot bin

.PHONY: all
all: ${SUBDIRS}
	set -e && for i in ${SUBDIRS}; do ${MAKE} -C $$i; done

.PHONY: deb
deb: ${DEBS}

${HEADERS_DEB}: ${KERNEL_DEB}
${KERNEL_DEB}: debian
	rm -rf ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}/debian
	rsync -a * ${BUILD_DIR}/
	cd ${BUILD_DIR}; debian/rules debian/control
	echo "git clone git://git.proxmox.com/git/pve-kernel-meta.git\\ngit checkout ${GITVERSION}" > ${BUILD_DIR}/debian/SOURCE
	cd ${BUILD_DIR}; dpkg-buildpackage -b -uc -us
	lintian ${DEBS}

.PHONY: install
install: ${SUBDIRS}
	set -e && for i in ${SUBDIRS}; do ${MAKE} -C $$i $@; done

.PHONY: upload
upload: ${DEBS}
	tar cf - ${DEBS}|ssh repoman@repo.proxmox.com -- upload --product pve,pmg,pbs --dist bullseye

.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *~ ${BUILD_DIR} *.deb *.dsc *.changes *.buildinfo
