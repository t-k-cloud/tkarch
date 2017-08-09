#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
pull files from flash stick and restore desktop. (root permission required)
you may need to specify "overwrite_all_proj" to overwrite those projects
cloned by tkarch scripts.
Examples:
$0
$0 overwrite_all_proj
USAGE
exit
fi

# permission check
touch /root/test || exit

overwrite_all_proj=false
if [ $1 ]; then
	[ $1 != 'overwrite_all_proj' ] && echo 'bad arg.' && exit
	overwrite_all_proj=true
fi

doing=''
if $overwrite_all_proj; then
	doing='"overwrite-pull"'
else
	doing='"regular-pull"'
fi

echo "[ start to do $doing in 10s, be sure you wanna do this ]"
sleep 10

shadow=tk-sync-shadow.sh
trash=tk-sync-trash.sh
PROJ=/home/tk/tksync/proj

# mount USB drive
echo "[ looking for usb drive... ]"
MNT_DIR=/var/mnt/tksync-flash-drive
tk-sync-mount.sh "$MNT_DIR"

# sync USB drive
if [ -e "$MNT_DIR"/tksync ]
then
	if $overwrite_all_proj; then
		echo "[ age initial projects timestamp... ]"
		find "$PROJ" -print0 | xargs -0 touch --date=@0
	fi

	echo "[ pull files from flash storage... ]"
	"$shadow" preserve "$MNT_DIR"/tksync /home/tk/tksync
	
	echo "[ restore exe-mode files' permission... ]"
	EXE_LIST=/home/tk/tksync/exe.list
	cat $EXE_LIST | while read -d $'\0' filepath
	do
		echo "[ +x $filepath ]"
		chmod +x "$filepath"
	done

	echo "[ http files permission reset... ]"
	tk-blog-rst-perm.sh
else
	echo "[ '$MNT_DIR/tksync' not presents ]"
fi

desktop_path="/home/tk/tksync/var"
echo "[ desktop path: $desktop_path ]"
if [ -e "$desktop_path" ]; then
	echo "[ restore desktop... ]"
	"$shadow" preserve "$desktop_path" /home/tk/Desktop
else
	echo "[ restore no desktop ]"
fi

"$trash" space occupied 
echo "[ sudo umount $MNT_DIR ]"
