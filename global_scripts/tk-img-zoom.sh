#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Zoom an image and output to a new file.
Examples:
$0 45% ./test.png  
USAGE
exit
fi

[ $# -ne 2 ] && echo 'bad arg.' && exit

percentage="$1"
img=$2
new_img="zoom-`basename $img`"

convert -resize "${percentage}x${percentage}" "$img" "$new_img"
