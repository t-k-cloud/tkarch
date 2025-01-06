#!/bin/sh
function echo_dev_num() {
	echo $(basename "$1" | grep -o '[[:digit:]]*$')
}

N_BIOSBOOT=$(echo_dev_num $DISKPART_BIOSBOOT)
N_BOOT=$(echo_dev_num $DISKPART_BOOT)
N_SWAP=$(echo_dev_num $DISKPART_SWAP)
N_ROOT=$(echo_dev_num $DISKPART_ROOT)

parted $DISKPART_DEV --script print

# erase partition table completely
sectors=`blockdev --getsize $DISKPART_DEV`
tput setaf 2; echo "$DISKPART_DEV has $sectors sectors in total, erase in 10 sec..."; tput sgr0;
sleep 10

tput setaf 2; echo "erase disk head ..."; tput sgr0;
dd if=/dev/zero of=$DISKPART_DEV bs=512 count=8192
tput setaf 2; echo "erase disk tail ..."; tput sgr0;
dd if=/dev/zero of=$DISKPART_DEV bs=512 seek=`expr $sectors - 8192` count=8192

tput setaf 2; echo 'creating partitions and make filesystems...'; tput sgr0;
# GPT table creation
parted $DISKPART_DEV --script mklabel gpt
# 2M grub boot code
parted $DISKPART_DEV --script mkpart primary 1MiB 3MiB
parted $DISKPART_DEV --script name $N_BIOSBOOT tkarch_grub
parted $DISKPART_DEV --script set $N_BIOSBOOT bios_grub on
# 1GiB boot partition
parted $DISKPART_DEV --script mkpart primary 4MiB 1000MiB
parted $DISKPART_DEV --script name $N_BOOT tkarch_boot
parted $DISKPART_DEV --script set $N_BOOT boot on
mkfs.ext4 -F $DISKPART_BOOT
# 4GiB swap partition
parted $DISKPART_DEV --script mkpart primary 1001MiB 5000MiB
parted $DISKPART_DEV --script name $N_SWAP tkarch_swap
mkswap -f $DISKPART_SWAP
swapon    $DISKPART_SWAP
# root partition using the rest of the disk
parted $DISKPART_DEV --script mkpart primary 5001MiB -- -1MiB
parted $DISKPART_DEV --script name $N_ROOT tkarch_root
mkfs.ext4 -F $DISKPART_ROOT

tput setaf 2; echo 'resulting parition:'; tput sgr0;
parted $DISKPART_DEV --script print
