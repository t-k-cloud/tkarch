is_connected () {
	wget --spider http://www.baidu.com 2> /dev/null
	if [ $? -eq 0 ]; then
		echo 'Internet connected.'
		return 0;
	else
		echo 'Internet is not connected.'
		return 1;
	fi
}
