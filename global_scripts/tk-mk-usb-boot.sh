#!/bin/bash
example="Example: $0 [uefi|legacy] /dev/sdX"

if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Make usb-stick bootable.
$example
USAGE
exit
fi

if [ $# -ne 2 ]; then
	echo "bad arg. $example"
	exit
fi;

touch '/root/perm-test' || exit

partmode="$1"
devpath="$2"

echo "unmounting..."
mntdir=`mount | grep "${devpath}1" | awk '{print $3}'`
if [ ! -z $mntdir ]; then
	echo "umount $mntdir"
	umount $mntdir
else
	echo "nothing to umount"
fi

sectors=`blockdev --getsize "$devpath"`
echo "erasing $sectors sectors..."
dd if=/dev/zero of="$devpath" bs=512 count=8192
dd if=/dev/zero of="$devpath" bs=512 seek=`expr $sectors - 8192` count=8192
sync

echo "partitioning..."
case "$partmode" in
    "legacy")
        # MBR table creation
        parted $devpath -- mklabel msdos
        # "boot and storage partition" using the rest of the disk
        parted $devpath -- mkpart primary 2MiB -1
        parted $devpath --script set 1 boot on
        rootpart=1
        ;;
    "uefi")
        # GPT table creation
        parted $devpath --script mklabel gpt
        # 2M grub boot code
        parted $devpath --script mkpart primary 1MiB 3MiB
        parted $devpath --script name 1 tkusb_post_mbr_code
        parted $devpath --script set 1 bios_grub on
        # "boot and storage partition" using the rest of the disk
        parted $devpath --script mkpart primary 4MiB -- -1MiB
        parted $devpath --script name 2 tkusb_boot_partition
        parted $devpath --script set 2 boot on
        rootpart=2
        ;;
    *)
        echo "Unknown partition mode: $partmode" ;;
esac
parted $devpath -- print

mkfs.vfat -F 32 -I "${devpath}${rootpart}"
# labels can be no longer than 11 characters
# and should be in uppercase.
dosfslabel "${devpath}${rootpart}" "TKBOOT"

mntdir=$(mktemp -d)
mount "${devpath}${rootpart}" $mntdir

case "$partmode" in
    "legacy")
        echo "installing MBR..."
        grub-install --target=i386-pc --boot-directory "${mntdir}/boot" $devpath
        ;;
    "uefi")
        echo "installing UEFI..."
        echo "make sure you have installed EFI utilities, i.e., efibootmgr on ArchLinux."
        grub-install --removable --target=x86_64-efi \
            --boot-directory "${mntdir}/boot" --efi-directory="${mntdir}" \
            --bootloader-id=tkusb_grub --recheck $devpath
        ;;
esac
touch ${mntdir}/boot/grub/grub.cfg

find $mntdir -type d
umount $mntdir
