#!/bin/bash
filename=`basename $0`
ow_script="/home/tk/$filename"
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
echo httpd user. 
If there is an overwrite-script ${ow_script}, execute that instead.
Examples:
$0
USAGE
exit
fi

if [ -e "${ow_script}" ]; then
	"${ow_script}"
else
	echo http:http
fi
