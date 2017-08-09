#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
backup desktop to tksync and push local files to flash stick. (root permission required)
Examples:
$0
USAGE
exit
fi

# permission check
touch /root/test || exit

shadow=tk-sync-shadow.sh
trash=tk-sync-trash.sh

echo "[ backup desktop... ]"
"$shadow" preserve /home/tk/Desktop "/home/tk/tksync/var"

# mount USB drive
echo "[ looking for usb drive... ]"
MNT_DIR=/var/mnt/tksync-flash-drive
tk-sync-mount.sh "$MNT_DIR"

# sync USB drive
if [ -e "$MNT_DIR"/tksync ]
then
	echo "[ searching exe-files... ]"
	EXE_LIST=/home/tk/tksync/exe.list
	find /home/tk/tksync -executable -type f -print0 > $EXE_LIST

	echo "[ sync flash storage... ]"
	"$shadow" no-preserve /home/tk/tksync "$MNT_DIR"/tksync
else
	echo "[ '$MNT_DIR/tksync' not presents ]"
fi

echo "[ flush file system buffers... ]"
sync

"$trash" space occupied 
echo "[ sudo tk-sync-mount.sh unmount ]"
