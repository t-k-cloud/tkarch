#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Link this folder's scripts to destination directory.

Examples:
$0 /etc/systemd/system
USAGE
exit
fi

# permission check
touch /root/test || exit 1

# extract arguments
SKIP=`basename ${0}`
CDIR=$(cd `dirname ${0}` && pwd)
DST=${1-/usr/local/bin}
TMP=`mktemp`

# generate a list of files to be linked
cd "${CDIR}"
find . -maxdepth 1 \( -path './.git' \) -prune -o ! \( -name '.' -o -name '*.swp' -o -name "${SKIP}" \) -print > $TMP

# link them to the directory specified by DST
cd "${DST}"
rm -f tk-*
while read script
do
	echo "symbol link $CDIR/$script to `pwd` ..."
	ln -sf "$CDIR/$script" .
done < $TMP
