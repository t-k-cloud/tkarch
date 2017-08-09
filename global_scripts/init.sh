#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Setup tk scripts in ${BIN}, root permission required.
Examples:
$0
USAGE
exit
fi

# permission check
touch /root/test || exit

SKIP=`basename ${0}`
CDIR=$(cd `dirname ${0}` && pwd)
BIN=/usr/local/bin
TMP=`mktemp`

cd "${CDIR}"

find . -maxdepth 1 \( -path './.git' \) -prune -o ! \( -name '.' -o -name '*.swp' -o -name "${SKIP}" \) -print > $TMP

cd "${BIN}"
rm -f tk-*
while read script
do
	echo "symbol link $CDIR/$script ..."
	ln -sf "$CDIR/$script" .
done < $TMP
