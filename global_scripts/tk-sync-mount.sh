#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
if tksync flash stick presents, remount it to specified path. (root permission required)
Examples:
$0 /var/mnt/tksync-flash-drive
$0 unmount
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit

# permission check
touch /root/test || exit
MNT_DIR="$1"

function do_mount() {
	mount -t exfat $devpath $MNT_DIR -o \
	rw,uid=`id -u tk`,gid=`id -g tk`,utf8,dmask=002,fmask=113
}

uuid=`tk-echo-flash-uuid.sh`
devpath=`readlink -f "/dev/disk/by-uuid/${uuid}"`
mntdir=`mount | grep "$devpath" | awk '{print $3}'`

if [ $MNT_DIR == 'unmount' ]; then
	if [ ! -z $mntdir ]; then
		echo "[ umount $mntdir ]"
		umount $mntdir
	else
		echo "[ nothing to umount ]"
	fi
	exit
fi

mkdir -p $MNT_DIR

if [ $mntdir ]; then
	if [ $mntdir != $MNT_DIR ]; then
		echo "[ $mntdir is mounted, re-mount it to $MNT_DIR. ]"
		umount -l $mntdir
		do_mount
	else
		echo "[ $MNT_DIR is already mounted. ]"
	fi
else
	if [ -e $devpath ]; then
		echo "[ mounting usb drive $uuid  ]"
		do_mount
	else
		echo "[ no tksync usb device ]"
	fi
fi
