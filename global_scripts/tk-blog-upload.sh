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
url='http://127.0.0.1/tkblog/entry.php?id=0'

if [ $# -eq 0 ] 
then
	echo "agreement expected."
	exit
elif [ $# -eq 2 ]
then
	if [ $2 == "publish" ] 
	then
		publish="ifPublish=1"
		url='http://127.0.0.1/tkblog/index.php'
	else
		echo "bad agreement."
		exit
	fi
fi
curl -F $publish -F "action=upload" -F "files=@${1}" 'http://127.0.0.1/tkblog/file_input.php'
