#!/bin/sh
function echo_dev_num() {
	echo $(basename "$1" | grep -o '[[:digit:]]*')
}

N_BIOSBOOT=$(echo_dev_num $DISKPART_BIOSBOOT)
N_BOOT=$(echo_dev_num $DISKPART_BOOT)
N_SWAP=$(echo_dev_num $DISKPART_SWAP)
N_ROOT=$(echo_dev_num $DISKPART_ROOT)

parted $DISKPART_DEV --script print

if ! $GRUB_ELF_INSTALL; then
	# erase partition table completely
	sectors=`blockdev --getsize $DISKPART_DEV`
	tput setaf 2; echo "$DISKPART_DEV has $sectors sectors in total, erase in 10 sec..."; tput sgr0;
	sleep 10
	tput setaf 2; echo "erase disk head ..."; tput sgr0;
	dd if=/dev/zero of=$DISKPART_DEV bs=512 count=8192
	tput setaf 2; echo "erase disk tail ..."; tput sgr0;
	dd if=/dev/zero of=$DISKPART_DEV bs=512 seek=`expr $sectors - 8192` count=8192

	tput setaf 2; echo 'creating partition table...'; tput sgr0;
	# GPT table creation
	parted $DISKPART_DEV --script mklabel gpt
	# 2M grub loader
	parted $DISKPART_DEV --script mkpart primary 1MiB 3MiB
	parted $DISKPART_DEV --script name $N_BIOSBOOT tkarch_grub
	parted $DISKPART_DEV --script set $N_BIOSBOOT bios_grub on
	# 128M boot partition
	parted $DISKPART_DEV --script mkpart primary 4MiB 200MiB
	# 512M swap partition
	parted $DISKPART_DEV --script mkpart primary 201MiB 900MiB
	# root partition for the rest of the disk
	parted $DISKPART_DEV --script mkpart primary 901MiB -- -1MiB
	# mark EFI System Partition
	parted $DISKPART_DEV --script set $N_BOOT boot on
fi;

tput setaf 2; echo 'name partitions...'; tput sgr0;
parted $DISKPART_DEV --script name $N_BOOT tkarch_boot
parted $DISKPART_DEV --script name $N_SWAP tkarch_swap
parted $DISKPART_DEV --script name $N_ROOT tkarch_root

tput setaf 2; echo 'making filesystem...'; tput sgr0;
if ! $GRUB_ELF_INSTALL; then mkfs.vfat $DISKPART_BIOSBOOT; fi;
mkfs.ext4 -F $DISKPART_BOOT
mkswap -f    $DISKPART_SWAP
swapon       $DISKPART_SWAP
mkfs.ext4 -F $DISKPART_ROOT

tput setaf 2; echo 'resulting parition:'; tput sgr0;
parted $DISKPART_DEV --script print
