#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Copy this folder's scripts to destination directory.

Examples:
$0 /etc/systemd/system
USAGE
exit
fi

# permission check
touch /root/test || exit

SKIP=`basename ${0}`
CDIR=$(cd `dirname ${0}` && pwd)
DST=${1-/usr/local/bin}
TMP=`mktemp`

cd "${CDIR}"
find . -maxdepth 1 \( -path './.git' \) -prune -o ! \( -name '.' -o -name '*.swp' -o -name "${SKIP}" \) -print > $TMP

cd "${DST}"
rm -f tk-*
while read script
do
	echo "symbol link $CDIR/$script ..."
	ln -sf "$CDIR/$script" .
done < $TMP
