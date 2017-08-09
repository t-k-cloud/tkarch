# setup for root
echo 'Please create root password:'
while ! passwd; do :; done

# setup for user
useradd -m -G wheel -s /bin/bash $USERNAME

echo "Please create $USERNAME password:"
while ! passwd $USERNAME; do :; done
