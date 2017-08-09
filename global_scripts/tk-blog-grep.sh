#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
grep tkblog text files.
Examples:
$0 'some regex'
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit

r_path=/home/tk/tksync/proj/tkblog
cd $r_path
patten=$1
find . -type f -name '*.txt' -print0 | while read -d $'\0' i
do
	grep -n -h -C 10 --color "$patten" $i && echo -e "[ $i ]\n" 
done
echo "[ tkblog path: $r_path ]"
