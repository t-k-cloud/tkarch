#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Trash instead of rm a file/directory. (root permission required)
Examples:
$0 put ./something 
$0 list all 
$0 empty all 
$0 space occupied 
USAGE
exit
fi

# permission check
touch /root/test || exit

trash_dir=/home/tk/tktrash
trash_record=/home/tk/tktrash.record

function GetDirAndObj
{
	fields=`echo "'$1'" | awk -F/ '{print NF}'`
	obj=`echo "$1" | awk -F/ '{print $NF}'`

	if [ $fields == '1' ]
	then
		dir=.
	else
		dir=`echo "$1" | cut -d '/' -f -$(let 'n=fields-1' && echo $n)`
		test ! "$dir" && dir=' '
	fi
}

if [ ! -e "$trash_dir" ]
then
	mkdir "$trash_dir"
fi

if [ ! "$2" ]
then
	echo 'you are not using this cmd correctly.(error 0)'
	exit
fi	

if [ $1 == 'put' ]
then
	if [ ! -e "$2" -a ! -L "$2" ]
	then 
		echo 'cannot find this directory or file.(error 2)'
		exit
	fi

	save_wd="$(pwd)"

	#now we are going to get a nice-looking path and object name
	if [ -d "$2" ]
	then
		cd "$2"
		GetDirAndObj "$(pwd)"
		trash_name="$obj"
		cd ..
		abs_dir="$(pwd)"
	else 
		GetDirAndObj "$2"
		trash_name="$obj"
		cd "$dir"
		abs_dir="$(pwd)"
	fi

	cd "$save_wd"
	while true
	do
		if [ -e "$trash_dir"/"$trash_name" ]
		then
			trash_name="${trash_name}_"
		else
		mv "$2" "$trash_dir/$trash_name"
		echo "/$trash_name/ $abs_dir" >> $trash_record
			break
		fi
	done
elif [ $1 == 'list' -a $2 == 'all' ]
then
	ls -a "$trash_dir"
elif [ $1 == 'empty' -a $2 == 'all' ]
then
	find "$trash_dir" -print0 | xargs -0 rm -rf
	> "$trash_record"

	mkdir "$trash_dir"
	du -s -h "$trash_dir"
elif [ $1 == 'space' -a $2 == 'occupied' ]
then
	echo -n "[ Trash: "
	du -s -h -0 "$trash_dir"
	echo " ]"

	dir_name=$(dirname "$0")
	echo "[ sudo $0 empty all ]"
else
	echo 'you are not using this cmd correctly.(error 1)'
fi
