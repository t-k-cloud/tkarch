#!/bin/bash
tksync_path=/home/tk/tksync
blog_root=/usr/share/nginx/html/tkblog
http_user=http
desktop=/home/tk/Desktop

#############
# Copy Blog 
#############
if [ ! -e "$tksync_path" ] 
then
	echo "sync path not found."
	exit 1
fi

echo "copy blog files..."
if [ ! -e "$blog_root" ] 
then
	echo "making blog directory..."
	mkdir -p "$blog_root"
	if [ $? -eq 1 ] 
	then
		echo 'permission denied.' 
		exit 1
	fi		
fi

target="$blog_root/blog"
echo "target: ${target}"
if [ -e "$target" ]
then
	echo "skip cp target: $target"
else
	cp -r "${tksync_path}/tkblog/blog" "$target"
fi

target="$blog_root/twbook"
echo "target: ${target}"
if [ -e "$target" ]
then
	echo "skip cp target: $target"
else
	cp -r "${tksync_path}/tkblog/twbook" "$target"
fi

has_something=$(ls "${blog_root}/"*.php 2> /dev/null | wc -l)
echo "has some php in ${blog_root} ? ${has_something} file(s)."

if [ $has_something != "0" ]
then
	echo "skip cp php files"
else
	echo "copy php files..."
	cp -ar "${tksync_path}/tkblog/blog_frame/." "$blog_root/"
fi

echo "changing ownership/permission in $blog_root ..."
sudo find "$blog_root" -type d -exec chmod 755 {} \;
sudo find "$blog_root" -type f -exec chmod 644 {} \;
sudo find "$blog_root" -type d -exec chown ${http_user}:${http_user} {} \;
sudo find "$blog_root" -type f -exec chown ${http_user}:${http_user} {} \;
sudo chmod 777 "$blog_root"

###############
# Copy Desktop 
###############
if [ "$(ls -A "${desktop}")" ] 
then
	echo "desktop is not empty, skip copying."
else
	echo "copy desktop files..."
	cp -ar "${tksync_path}/desktop/." "${desktop}/"
fi
exit
