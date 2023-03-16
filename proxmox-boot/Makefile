KERNEL_HOOKSCRIPTS = proxmox-auto-removal zz-proxmox-boot
INITRAMFS_HOOKSCRIPTS = proxmox-boot-sync
SHARE_FILES = functions
GRUB_CFG_SNIPPET = 000_proxmox_boot_header
SYSTEMD_SERVICES = proxmox-boot-cleanup.service

POSTINSTHOOKDIR = ${DESTDIR}/etc/kernel/postinst.d
POSTRMHOOKDIR = ${DESTDIR}/etc/kernel/postrm.d
POSTINITRAMFSHOOKDIR = ${DESTDIR}/etc/initramfs/post-update.d
SHARE_SCRIPTDIR = ${DESTDIR}/usr/share/proxmox-kernel-helper/scripts
GRUB_CFG_DIR = ${DESTDIR}/etc/grub.d
SERVICE_DIR = ${DESTDIR}/lib/systemd/system

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
	install -d ${GRUB_CFG_DIR}
	install -m 0755 ${GRUB_CFG_SNIPPET} ${GRUB_CFG_DIR}
	install -d ${SERVICE_DIR}
	install -m 0644 ${SYSTEMD_SERVICES} ${SERVICE_DIR}

.PHONY: clean distclean
distclean:
clean:
