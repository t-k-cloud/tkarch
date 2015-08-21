wget --spider http://www.google.com 2> /dev/null
if [ $? -eq 0 ]; then
	echo 'Internet connected.'
	exit 0;
else
	echo 'Internet is not connected.'
	exit 1;
fi
