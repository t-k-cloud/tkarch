# setup for root
while ! passwd; do :; done

# setup for user
useradd -m -G wheel -s /bin/bash $USERNAME
while ! passwd $USERNAME; do :; done
