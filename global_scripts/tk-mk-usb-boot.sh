#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Make a usb-stick bootloader.
Examples:
$0 /dev/sdc
USAGE
exit
fi

if [ $# -ne 1 ]; then
	echo 'bad arg.'
	exit
fi;

touch '/root/perm-test' || exit

devpath="$1"

echo "making usb-stick bootloader @${devpath} in 10s..."
sleep 10

echo "unmounting..."
mntdir=`mount | grep "${devpath}1" | awk '{print $3}'`
if [ ! -z $mntdir ]; then
	echo "umount $mntdir"
	umount $mntdir
else
	echo "nothing to umount"
fi

sectors=`blockdev --getsize "${devpath}"`
echo "erasing ${sectors} sectors..."
dd if=/dev/zero of="${devpath}" bs=512 count=8192
dd if=/dev/zero of="${devpath}" bs=512 seek=`expr $sectors - 8192` count=8192

echo "Please remove, re-insert u-stick in 20sec ..."
sleep 20

echo "partitioning..."
parted "${devpath}" -- mklabel msdos
parted "${devpath}" -- mkpart primary 2MiB -1
parted "${devpath}" -- toggle 1 boot

echo "making filesystem..."
mkfs.vfat -F 32 -I "${devpath}1"

# labels can be no longer than 11 characters
# and should be in uppercase.
dosfslabel "${devpath}1" "TKBOOT"

echo "done:"
parted "${devpath}" -- print

echo "Please remove, re-insert u-stick in 20sec ..."
sleep 20

echo "installing MBR..."
mntdir=`mount | grep "${devpath}1" | awk '{print $3}'`
grub-install --target=i386-pc "--root-directory=${mntdir}" "${devpath}"
