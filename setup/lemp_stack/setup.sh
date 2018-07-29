tput setaf 2; echo 'Installing LEMP stack...'; tput sgr0;

# install mariadb
pacman --noconfirm -S mariadb
# install nginx
pacman --noconfirm -S nginx
# install php-fpm
pacman --noconfirm -S php-fpm

# enable them
systemctl enable mysqld nginx php-fpm

# create user/group http
groupadd -f http
useradd -g http http

## make tk and http mutual-permissive
usermod tk -a -G http
usermod http -a -G tk
