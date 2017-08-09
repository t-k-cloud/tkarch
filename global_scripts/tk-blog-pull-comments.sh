#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
download a number of recent comments and upload to local-hosted blog.
Examples:
$0 6 
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit

IP_REMOTE=`tk-echo-bloghost-IP.sh`
NUM="$1"
#remote_url="http://${IP_REMOTE}/tkblog/pull.php?recent_comments=$NUM"
remote_url="https://approach0.xyz/tkblog/pull.php?recent_comments=$NUM"
tmp_list=`mktemp`
tmp_dir=`mktemp -d`

echo "[curl] $remote_url"
curl $remote_url > $tmp_list
cat $tmp_list

while read path
do
	filename=`basename $path`
	tput setaf 2; echo "[ pull $filename ]"; tput sgr0
	#curl "http://${IP_REMOTE}/tkblog/$path" > $tmp_dir/$filename
	curl "https://approach0.xyz/tkblog/$path" > $tmp_dir/$filename
	cat $tmp_dir/$filename
done < $tmp_list

cd $tmp_dir
find . -name '*.txt' | while read com 
do
	tput setaf 2; echo "[ upload to localhost: $com ]"; tput sgr0
	tk-blog-upload.sh "$com"
done
