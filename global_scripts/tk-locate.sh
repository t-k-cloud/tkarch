#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
locate/open a tksync file by path/name keywords.
Examples:
$0 -vim private memo
USAGE
exit
fi

[ "$#" == "0" ] && echo 'bad arg.' && exit

tmpfile=`mktemp`
opener=''

locate tksync > $tmpfile

while (( "$#" )); do
	if echo "$1" | grep -q '^-'; then
		opener=`echo "$1" | grep -Po '(?<=-).*'`
		echo "set opener='$opener'"
	else
		cat $tmpfile | grep "${1}" > ${tmpfile}.tmp
		mv ${tmpfile}.tmp ${tmpfile}
	fi

	shift
done

n_res=`wc -l ${tmpfile} | awk '{print $1}'`

if [ -z "$opener" ]; then
	cat ${tmpfile}
elif [ $n_res == '1' ]; then
	${opener} `cat ${tmpfile}`
else
	cat ${tmpfile}
fi
