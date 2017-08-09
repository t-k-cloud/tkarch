#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
update my schedule post file.
Examples:
$0
USAGE
exit
fi

file=2015-09-10-02-00-1089.txt
TMP=`mktemp -d`
tk-sched-show.py > $TMP/$file
sed -i '1s/^/\ttag:隐藏\n/' $TMP/$file
tput setaf 3 # yellow 
echo "[ $TMP/$file ]"
tput sgr0
tk-blog-upload.sh $TMP/$file
tk-blog-sync.sh remote schedule
