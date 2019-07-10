KERNEL_HOOKSCRIPTS = pve-auto-removal zz-pve-efiboot
SHARE_FILES = functions

HOOKDIR = ${DESTDIR}/etc/kernel/postinst.d
SHARE_SCRIPTDIR = ${DESTDIR}/usr/share/pve-kernel-helper/scripts

.PHONY: all
all:

install:
	install -d ${HOOKDIR}
	install -m 0755 ${KERNEL_HOOKSCRIPTS} ${HOOKDIR}
	install -d ${SHARE_SCRIPTDIR}
	install -m 0755 ${SHARE_FILES} ${SHARE_SCRIPTDIR}

.PHONY: clean distclean
distclean:
clean:
