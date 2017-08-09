#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
check all project repositories, show its git status if needs update.
Examples:
$0
USAGE
exit
fi

PROJ=/home/tk/tksync/proj
TMP=`mktemp`

function check()
{
	# go to that directory
	dir="`dirname ${1}`"
	tput setaf 4 # blue color
	echo "[ Git repository: ${dir} ]"
	tput sgr0
	cd "${dir}"

	# do we need git commit?
	git add -A .
	git reset
	# alert user if we need update
	git status | grep 'nothing to commit' || git status 
	# alert user if we need to pull 
	git fetch 
	git status | grep 'up-to-date' || git status
}

#check /home/tk/tksync/proj/tkblog/.git
#check /home/tk/tksync/proj/cowpie/.git

find "$PROJ" -type d -a -name '*.git' -print > $TMP

all_repo=`ls "$PROJ" | wc -l`
git_repo=`cat $TMP | wc -l`
echo "git repo / total projects = $git_repo / $all_repo"

while read repo 
do
	check "$repo"
done < $TMP
