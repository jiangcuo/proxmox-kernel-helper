KERNEL_HOOKSCRIPTS = proxmox-auto-removal zz-proxmox-boot
INITRAMFS_HOOKSCRIPTS = proxmox-boot-sync
SHARE_FILES = functions

POSTINSTHOOKDIR = ${DESTDIR}/etc/kernel/postinst.d
POSTRMHOOKDIR = ${DESTDIR}/etc/kernel/postrm.d
POSTINITRAMFSHOOKDIR = ${DESTDIR}/etc/initramfs/post-update.d
SHARE_SCRIPTDIR = ${DESTDIR}/usr/share/pve-kernel-helper/scripts

.PHONY: all
all:

install:
	install -d ${POSTINSTHOOKDIR}
	install -m 0755 ${KERNEL_HOOKSCRIPTS} ${POSTINSTHOOKDIR}
	install -d ${POSTRMHOOKDIR}
	install -m 0755 ${KERNEL_HOOKSCRIPTS} ${POSTRMHOOKDIR}
	install -d ${POSTINITRAMFSHOOKDIR}
	install -m 0755 ${INITRAMFS_HOOKSCRIPTS} ${POSTINITRAMFSHOOKDIR}
	install -d ${SHARE_SCRIPTDIR}
	install -m 0755 ${SHARE_FILES} ${SHARE_SCRIPTDIR}

.PHONY: clean distclean
distclean:
clean:
