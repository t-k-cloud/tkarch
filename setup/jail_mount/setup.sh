mount $DISKPART_ROOTDEV /mnt
mkdir -p /mnt/boot
mount $DISKPART_BOOTDEV /mnt/boot

if $GRUB_ELF_INSTALL; then
	mkdir -p /mnt/boot/efi
	mount $DISKPART_BIOSBOOT /mnt/boot/efi

	# clear old EFI entry
	rm -rf /mnt/boot/efi/EFI/
fi;
