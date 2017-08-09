#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Rotate an image and output to a new file.
Examples:
$0 180 ./test.png  
USAGE
exit
fi

[ $# -ne 2 ] && echo 'bad arg.' && exit

degree="$1"
img=$2
new_img="rotate-`basename $img`"

convert -rotate $degree "$img" "$new_img"
