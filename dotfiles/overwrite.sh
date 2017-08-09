#!/bin/bash
LIST=${HOME}/overwrite.list
SKIP=`basename ${0}`
CDIR=$(cd `dirname ${0}` && pwd)

echo "home directory: ${HOME}"
echo "cd directory: ${CDIR}"
echo "skip me: ${SKIP}"
echo "who am I: `whoami`"

> "$LIST"
cd "${CDIR}"
find . -maxdepth 1 \( -path './.git' \) -prune -o ! \( -name '.' -o -name '*.swp' -o -name "${SKIP}" \) -print >> "$LIST"

while read l 
do
	echo ln -sf "${CDIR}/${l}" "${HOME}/$l"
	ln -sf "${CDIR}/${l}" "${HOME}/$l"
done < "$LIST"
