tput setaf 2; echo 'Installing LEMP stack...'; tput sgr0;

# install nginx (E)
pacman --noconfirm -S nginx

# install mariadb (M)
pacman --noconfirm -S mariadb
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# install php-fpm (P)
pacman --noconfirm -S php-fpm

# enable them
systemctl enable mysqld nginx php-fpm

# create user/group http
groupadd -f http
useradd -g http http

## make user and http mutual-permissive
usermod $USERNAME -a -G http
usermod http -a -G $USERNAME
