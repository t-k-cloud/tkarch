tput setaf 2; echo 'Installing LEMP stack...'; tput sgr0;

# install mariadb
pacman --noconfirm -S mariadb
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mysqld
tmp_passwd=tmp
echo -e "\ny\n${tmp_passwd}\n${tmp_passwd}\ny\ny\ny\ny" | mysql_secure_installation
# create a mysql user for my blog
mysql -u root --password=tmp << EOF
CREATE USER 'thoughts_ga6840'@'localhost' IDENTIFIED BY 'xxxxxxxxxxxxx';
create database thoughts_ga6840;
GRANT ALL PRIVILEGES ON thoughts_ga6840.* TO 'thoughts_ga6840'@'%' IDENTIFIED BY 'xxxxxxxxxxxxx';
EOF
# install nginx
pacman --noconfirm -S nginx
systemctl start nginx
# install php-fpm
pacman --noconfirm -S php-fpm php-gd
systemctl start php-fpm
# patch /etc/nginx/nginx.conf to enble php handler
change_to=/root/tkarch/setup/lemp_stack/nginx-php-config.txt
sed -i "/index\.php/r ${change_to}" /etc/nginx/nginx.conf
# make sure worker-thread user is correct
sed -i "/user .*/d" /etc/nginx/nginx.conf
sed -i '1s/^/user http;\n/' /etc/nginx/nginx.conf
# specify error log file
sed -i '1s/^/error_log \/tmp\/nginx-error.log;\n/' /etc/nginx/nginx.conf
# add index.php as additional index page
sed -i "s/index\.html/index\.html index\.php/g" /etc/nginx/nginx.conf
# create user/group http
groupadd -f http
useradd -g http http
# patch /etc/php/php.ini to change open_basedir and display_errors 
sed -i '/open_basedir.*=/c ;open_basedir =' /etc/php/php.ini
sed -i 's/display_errors = Off/display_errors = On/' /etc/php/php.ini
# patch /etc/php/php.ini to enable necessary modules
sed -i 's/;extension=mysql\.so/extension=mysql\.so/' /etc/php/php.ini
sed -i 's/;extension=mysqli\.so/extension=mysqli\.so/' /etc/php/php.ini
sed -i 's/;extension=gd\.so/extension=gd\.so/' /etc/php/php.ini
sed -i 's/;extension=pdo_mysql\.so/extension=pdo_mysql\.so/' /etc/php/php.ini
# ensure that all of the LEMP programs start automatically
systemctl restart php-fpm nginx
systemctl enable mysqld nginx php-fpm
ps -aux | grep nginx | grep worker # test
httpd_root=/usr/share/nginx/html
# write some test pages for php error and sql
cp -r /root/tkarch/setup/lemp_stack/test-php $httpd_root
# set permission
find $httpd_root -type d -exec chmod 755 {} \;
find $httpd_root -type f -exec chmod 664 {} \;
find $httpd_root -type d -exec chown http:http {} \;
find $httpd_root -type f -exec chown http:http {} \;
chmod 777 $httpd_root # this should be after "find chmod of dir"
