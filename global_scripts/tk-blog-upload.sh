#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Upload a blog from command line.
Examples:
$0 ./new.blog
$0 ./new.blog publish
USAGE
exit
fi

publish="abc=1"
#ip=`curl https://t-k-cloud.github.io 2> /dev/null | grep 'var IP' | grep -o '[0-9.]*'`
ip='127.0.0.1' # for fast preview, use localhost instead.
url="http://${ip}/tkblog/file_input.php"

if [ $# -eq 0 ] 
then
	echo "agreement expected."
	exit
elif [ $# -eq 2 ]
then
	if [ $2 == "publish" ] 
	then
		publish="ifPublish=1"
	else
		echo "bad agreement."
		exit
	fi
fi
curl -F $publish -F "action=upload" -F "files=@${1}" "${url}" &> /dev/null
echo "== Done == (IP: $ip)"
