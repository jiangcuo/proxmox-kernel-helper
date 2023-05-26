include /usr/share/dpkg/pkg-info.mk

PACKAGE=proxmox-kernel-helper
BUILDDIR=$(PACKAGE)-$(DEB_VERSION_UPSTREAM)

DSC=$(PACKAGE)_$(DEB_VERSION).dsc
DEB=$(PACKAGE)_$(DEB_VERSION)_all.deb

.PHONY: deb
deb: $(DEB)

$(BUILDDIR): debian src
	rm -rf $@ $@.tmp
	cp -a src $@.tmp
	cp -a debian $@.tmp/
	echo "git clone git://git.proxmox.com/git/proxmox-kernel-helper.git\\ngit checkout $$(git rev-parse HEAD)" > $@.tmp/debian/SOURCE
	mv $@.tmp $@

$(DEB): $(BUILDDIR)
	cd $(BUILDDIR); dpkg-buildpackage -b -uc -us
	lintian $(DEB)

dsc: clean
	$(MAKE) $(DSC)
	lintian $(DSC)

$(DSC): $(BUILDDIR)
	cd $(BUILDDIR); dpkg-buildpackage -S -uc -us -d

sbuild: $(DSC)
	sbuild $<

.PHONY: upload
upload: $(DEB)
	tar cf - $(DEB)|ssh repoman@repo.proxmox.com -- upload --product pve,pmg,pbs --dist bullseye

.PHONY: clean distclean
distclean: clean
clean:
	$(MAKE) -C src $@
	rm -rf *~ $(PACKAGE)-[0-9]*/ $(PACKAGE)*.tar* *.deb *.dsc *.changes *.build *.buildinfo
