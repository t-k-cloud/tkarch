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
url="https://vm.xitizu.com/tkblog/file_input.php"

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
echo "== Done =="
