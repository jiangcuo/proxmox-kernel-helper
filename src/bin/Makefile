SBINDIR=${DESTDIR}/usr/sbin

.PHONY: all
all:

install:
	install -d ${SBINDIR}
	install -m 0755 proxmox-boot-tool ${SBINDIR}/
	install -m 0755 grub-install-wrapper ${SBINDIR}/grub-install

.PHONY: clean distclean
distclean:
clean:
