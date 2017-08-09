#!/bin/bash
logfile=/var/log/tk-sync-goodnight.log
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
this script is designed for a shortcut of everything-sync (typically) 
before going to sleep. (root permission required and make sure you 
have Internet). 
Make sync-gitcheck green, plugin USB driver and have a good night!
The sync-push output is logged to: $logfile
Examples:
$0
$0 no-shutdown
USAGE
exit
fi
# permission check
touch /root/test || exit

# parse the no-shutdown option, if any.
shutdown=true
if [ ! -z $1 ]; then
	if [ $1 == "no-shutdown" ]; then
		shutdown=false
	else
		echo "bad arg: $1" && exit
	fi
fi

echo -n 'about to say goodnight... '
if $shutdown; then
	echo '(and shutdown)'
else
	echo '(without shutdown)'
fi

# reminder
tput setaf 3 # yellow 
echo "it's better to sync-git before sync everything here!"
echo "you have 10 secs to kill this before saying goodnight."
tput sgr0
sleep 10

# blog updates 
#sudo -u tk bash << EOF
#tk-blog-sync.sh remote `date +"%Y"`/`date +"%-m"`
#tk-sched-update.sh
#EOF

# sync-push
mkdir -p /var/log
echo "LOG (`date`):" >> $logfile
tk-sync-push.sh | tee -a $logfile

if $shutdown; then
	# unmount and shutdown!
	tput setaf 3 # yellow 
	tk-sync-mount.sh unmount
	echo "10 seconds before poweroff!"
	tput sgr0
	sleep 10
	systemctl poweroff
fi
