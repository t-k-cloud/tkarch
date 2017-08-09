#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Format tksync flash stick. (root permission required)
Examples:
$0 /dev/sdc
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit

# permission check
touch /root/test || exit

devpath="$1"

echo "Unmount..."
tk-sync-mount.sh unmount

echo "Formating $1 in 5 secs."
sleep 5

sectors=$(blockdev --getsize $devpath)
dd if=/dev/zero of=$devpath bs=512 count=8192
dd if=/dev/zero of=$devpath bs=512 seek=`expr $sectors - 8192` count=8192

parted $devpath --script mklabel msdos
parted $devpath --script mkpart primary 1MiB -- -1MiB
parted $devpath --script print

echo "Creating file system on ${devpath}1 in 5 sec..."
sleep 5
mkfs.exfat -n tksync ${devpath}1
# tune2fs ${devpath}1 -U `tk-echo-flash-uuid.sh`

echo "Done:"
blkid | grep "$devpath"
parted $devpath --script print
