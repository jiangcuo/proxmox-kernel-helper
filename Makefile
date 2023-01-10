include /usr/share/dpkg/pkg-info.mk

GITVERSION:=$(shell git rev-parse HEAD)

DEB=proxmox-kernel-helper_${DEB_VERSION_UPSTREAM_REVISION}_all.deb

BUILD_DIR=build

SUBDIRS = proxmox-boot bin

.PHONY: all
all: ${SUBDIRS}
	set -e && for i in ${SUBDIRS}; do ${MAKE} -C $$i; done

.PHONY: deb
deb: ${DEB}

${DEB}: debian
	rm -rf ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}/debian
	rsync -a * ${BUILD_DIR}/
	echo "git clone git://git.proxmox.com/git/proxmox-kernel-helper.git\\ngit checkout ${GITVERSION}" > ${BUILD_DIR}/debian/SOURCE
	cd ${BUILD_DIR}; dpkg-buildpackage -b -uc -us
	lintian ${DEB}

.PHONY: install
install: ${SUBDIRS}
	set -e && for i in ${SUBDIRS}; do ${MAKE} -C $$i $@; done

.PHONY: upload
upload: ${DEB}
	tar cf - ${DEB}|ssh repoman@repo.proxmox.com -- upload --product pve,pmg,pbs --dist bullseye

.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *~ ${BUILD_DIR} *.deb *.dsc *.changes *.buildinfo
