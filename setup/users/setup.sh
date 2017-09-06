# setup for root
if [ -z $ROOTPASS ]; then
	echo 'Please set a root password:'
	while ! passwd; do :; done
else
	: # passwd --stdin deprecated, use chpasswd.
fi

# setup for user
useradd -m -G wheel -s /bin/bash $USERNAME

if [ -z $USERPASS ]; then
	echo "Please set $USERNAME password:"
	while ! passwd $USERNAME; do :; done
else
	: # passwd --stdin deprecated, use chpasswd.
fi
