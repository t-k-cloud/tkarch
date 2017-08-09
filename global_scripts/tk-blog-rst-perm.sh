#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
reset tkblog file to default httpd permission. (root permission required)
Examples:
$0
$0 /path/to/tkblog # absolute path
USAGE
exit
fi

# permission check
touch /root/test || exit

blog_dir=/home/tk/tksync/proj/tkblog
if [ ! -z $1 ]
then
	blog_dir="$1"
fi
echo "[ $blog_dir permission reset ]"

httpd_usr=`tk-echo-httpd-user.sh`

find "$blog_dir" -type d -print0 | xargs -0 chown "$httpd_usr"
find "$blog_dir" -type f -print0 | xargs -0 chown "$httpd_usr"
find "$blog_dir" -type d -print0 | xargs -0 chmod 775

# chown of file is a little tricky, since executable file should preserve its execution permission.
find "$blog_dir" -type f -print0 | while read -d $'\0' file; do
	if [[ -x "$file" ]]; then
		echo "preserve executable [${file}]"
		chmod 774 "$file"
	else
		chmod 664 "$file"
	fi
done
