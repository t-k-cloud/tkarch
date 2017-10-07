mount $DISKPART_ROOT /mnt
mkdir -p /mnt/boot
mount $DISKPART_BOOT /mnt/boot

if $GRUB_ELF_INSTALL; then
	mkdir -p /mnt/boot/efi
	mount $DISKPART_BIOSBOOT /mnt/boot/efi

	# clear old EFI entry
	rm -rf /mnt/boot/efi/EFI/
fi;
