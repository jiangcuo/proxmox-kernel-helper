include /usr/share/dpkg/pkg-info.mk

PACKAGE=proxmox-kernel-helper
BUILDDIR=build

DEB=$(PACKAGE)_$(DEB_VERSION)_all.deb

SUBDIRS = proxmox-boot bin

.PHONY: all
all: $(SUBDIRS)
	set -e && for i in $(SUBDIRS); do $(MAKE) -C $$i; done

.PHONY: deb
deb: $(DEB)

$(BUILDDIR): debian
	rm -rf $@ $@.tmp
	rsync -a * $@.tmp/
	echo "git clone git://git.proxmox.com/git/proxmox-kernel-helper.git\\ngit checkout $$(git rev-parse HEAD)" > $@.tmp/debian/SOURCE
	mv $@.tmp $@

$(DEB): $(BUILDDIR)
	cd $(BUILDDIR); dpkg-buildpackage -b -uc -us
	lintian $(DEB)

.PHONY: install
install: $(SUBDIRS)
	set -e && for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done

.PHONY: upload
upload: $(DEB)
	tar cf - $(DEB)|ssh repoman@repo.proxmox.com -- upload --product pve,pmg,pbs --dist bullseye

.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *~ $(PACKAGE)-[0-9]*/ $(PACKAGE)*.tar* *.deb *.dsc *.changes *.build *.buildinfo
