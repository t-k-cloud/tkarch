#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
"image" a directory or file from another, absolute path
should be specified. (root permission required). The no-
preserve option is designed for shadow FAT/exFAT filesys. 
Examples:
$0 no-preserve \`pwd\`/ori \`pwd\`/sha
$0 preserve \`pwd\`/ori \`pwd\`/sha
USAGE
exit
fi

# permission check
touch /root/test || exit

script_dir=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd`
trash=tk-sync-trash.sh
option="$1"
from=$2
to=$3

if [ "$option" != "preserve" -a "$option" != "no-preserve" ]
then
	echo 'err: option must be either "preserve" or "no-preserve"'
	exit
fi

function print_list() {
	while read -d $'\0' item 
	do
		echo "$item"
	done < "$1"
}

function shadow_rm()
{
cd "$to"
TMP=`mktemp`
find . -type $1 -print0 > "$TMP"

# print_list "$TMP"
while read -d $'\0' i
do
	if [ ! $2 "${to}/${i}" ]
	then
		# echo "already-removed file skiped..."
		continue
	fi

	if [ ! $2 "${from}/${i}" ]
	then
		echo "trash [ ${to}/${i} ]"
		"$trash" put "${to}/${i}"
	fi
done < "$TMP"
}

if [ -d "$from" ]
then
	echo "shadow [ $to ]"

	mkdir -p "$to"
	shadow_rm d -d
	shadow_rm f -e
	shadow_rm l -L
	
	# NOTE:
	# 1) file names that contain '\r' ':' or symbol links may
	#    be illegal in MS-DOS file systems.
	# 2) without sudo, cp fails when overwrite write-protected
	#    file', i.e. file mode with r--r--r--
	sed_git='sed -e "/\/.git\//c\[ one git file copied ]"'
	if [ "$option" == "preserve" ]; then
		echo "update [ $to ]"
		bash -c "cp -v -L -u -r -a \"$from\"/. \"$to\" | ${sed_git}"
	else
		echo "update [ $to ] (preserve only timestamps)"
		bash -c "cp -v -L -u -r --preserve=timestamps \"$from\"/. \"$to\" | ${sed_git}"
	fi
elif [ -f "$from" ]
then
	echo "sync [ $to ]"

	dirname=`dirname "$to"`
	mkdir -p "$dirname"
	cp -u "$from" "$to"
else
	echo "error [ $from ]"
	echo "*********** file type unexpected. ***********" && exit
fi
