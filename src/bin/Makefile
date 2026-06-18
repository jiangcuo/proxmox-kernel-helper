SBINDIR=${DESTDIR}/usr/sbin
HAS_APT := $(shell which apt 2>/dev/null)

.PHONY: all
all:

install:
	install -d ${SBINDIR}
	install -m 0755 proxmox-boot-tool ${SBINDIR}/
	install -m 0755 grub-install-wrapper ${SBINDIR}/grub-install
ifeq ($(HAS_APT),)
	install -m 0755 update-grub ${SBINDIR}/
	install -m 0755 update-initramfs ${SBINDIR}/
endif

.PHONY: clean distclean
distclean:
clean:
