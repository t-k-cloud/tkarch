if $GRUB_ELF_INSTALL; then
	pacmanS efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck

	# change EFI entry icon
	cp /root/tkarch/setup/grub_install/os_linux.icns /boot/efi/EFI/arch_grub/grubx64.icns

	# list what we got
	find /boot/efi/
else
	grub-install --recheck $DISKPART_DEV
fi;

grub-mkconfig -o /boot/grub/grub.cfg
