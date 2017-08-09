#!/bin/sh
[ ! $# -eq 2 ] && echo "bad arg. Example: $0 /usr/share/nginx/html http" && exit
http_root="$1"
http_user="$2"
proj_dir=/home/tk/tksync/proj

touch /root/test || exit
mkdir -p /usr/local/bin

echo "make sure Internet is connected and fast to use service: pip install, Github and Google/pepper-flash."
sleep 10

tput setaf 2; echo 'pip install packages...'; tput sgr0;
pip_mirror="--index https://pypi.mirrors.ustc.edu.cn/simple/"
pip install ${pip_mirror} feedparser # install feedparser
pip install ${pip_mirror} pycurl # used by cowpie and tk-sched-show
pip install ${pip_mirror} jieba whoosh # my blog search engine
# pacman --noconfirm -S sagemath # python2 math/ploting

# run as user tk:
sudo -u tk bash << EOF
tput setaf 2; echo "cd to ${proj_dir}"; tput sgr0;
mkdir -p ${proj_dir}
cd ${proj_dir}

tput setaf 2; echo 'Clone git projects...'; tput sgr0;
git clone https://github.com/t-k-/tkdotfiles.git
git clone https://github.com/t-k-/tkfeedr.git
git clone https://github.com/t-k-/tkscripts.git

tput setaf 2; echo 'tk: home config...'; tput sgr0;
./tkdotfiles/overwrite.sh

tput setaf 2; echo 'Make package chromium-pepper-flash...'; tput sgr0;
cd /home/tk
git clone https://aur.archlinux.org/chromium-pepper-flash-dev.git
cd chromium-pepper-flash-dev/
makepkg -s 
EOF

tput setaf 2; echo 'Install package chromium-pepper-flash...'; tput sgr0;
cd /home/tk/chromium-pepper-flash-dev/
pacman --noconfirm -U *.pkg.tar.xz
# Don't forget to enable the Adobe Flash Player plugin on chrome://plugins/

tput setaf 2; echo "cd to ${proj_dir}"; tput sgr0;
cd ${proj_dir}
 
tput setaf 2; echo 'root: home config...'; tput sgr0;
cp -r ${proj_dir}/tkdotfiles /root/
/root/tkdotfiles/overwrite.sh

tput setaf 2; echo 'root: feed init...'; tput sgr0;
./tkfeedr/init.sh

tput setaf 2; echo 'root: tkscripts init...'; tput sgr0;
./tkscripts/init.sh

tput setaf 2; echo 'root: tkblog init...'; tput sgr0;
git clone https://github.com/t-k-/tkblog.git

echo "http_root: $http_root"
echo "http_user: $http_user"

ln -sf ${proj_dir}/tkblog ${http_root}/tkblog
sed -i -e "s/www-data/${http_user}/g" './tkscripts/tk-echo-httpd-user.sh'
tk-blog-rst-perm.sh
chmod 755 /home/tk/
curl http://127.0.0.1/tkblog/panel_.php?init=db

# Later, to import all blog into mysql, user can simply run: tk-blog-sync.sh local .
# And start index blog posts by using tk-blog-searchd.sh



















tput setaf 2; echo 'Installing LEMP...'; tput sgr0;
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
change_to=/root/tkarch/nginx-php-config.txt
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
# write some test pages for php error and sql
cp /root/tkarch/test-php/* /usr/share/nginx/html
# set permission
httpd_root=/usr/share/nginx/html
find $httpd_root -type d -exec chmod 755 {} \;
find $httpd_root -type f -exec chmod 664 {} \;
find $httpd_root -type d -exec chown http:http {} \;
find $httpd_root -type f -exec chown http:http {} \;
chmod 777 $httpd_root # this should be after "find chmod of dir"

# install cgiwrap (used by cowpie maybe)
pacman --noconfirm -S fcgiwrap
systemctl enable fcgiwrap.socket
systemctl start fcgiwrap.socket # config file: /usr/lib/systemd/system/fcgiwrap.socket

##########################################
usermod tk -a -G http
usermod tk -a -G vboxusers 
usermod tk -a -G wireshark
##########################################

