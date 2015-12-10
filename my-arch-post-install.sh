#!/bin/sh
cur_dir=$(cd `dirname $0`; pwd)

. "$cur_dir"/my-arch-ping.sh
is_connected || exit 

tput setaf 2; echo 'Installing command line utilities...'; tput sgr0; 
pacman --noconfirm -S tmux curl vim ctags cscope flex bison 
pacman --noconfirm -S strace
pacman --noconfirm -S expect 
pacman --noconfirm -S enca 
pacman --noconfirm -S openssh # ssh command 
pacman --noconfirm -S imagemagick # 'convert' command
pacman --noconfirm -S ntp # NTP protocol time sync tool 
systemctl enable ntpd.service # start ntpd on boot
systemctl start ntpd.service # run ntp (sync time) now 
hwclock --systohc --utc # adjust hardware clock too
pacman --noconfirm -S mlocate # updatedb/locate
pacman --noconfirm -S dosfstools parted
pacman --noconfirm -S fuse-exfat exfat-utils # exFAT filesys
pacman --noconfirm -S python-pip # to install feedparser
pip install feedparser # install feedparser
pip install pycurl # used by cowpie and tk-sched-show
pip install jieba whoosh # my blog search engine
# pacman --noconfirm -S sagemath # python2 math/ploting

tput setaf 2; echo 'Replace vi with vim...'; tput sgr0;
ln -sf `which vim` `which vi`

tput setaf 2; echo 'Installing desktop environment...'; tput sgr0;
pacman --noconfirm -S xorg-server xorg-xinit xterm # X server
pacman --noconfirm -S xf86-input-synaptics # touchpad/touchscreen
pacman --noconfirm -S wqy-microhei # chinese font, Monospaced font included
pacman --noconfirm -S ttf-liberation # TTF font (otherwise MathJax is slow)
pacman --noconfirm -S cinnamon # desktop environment

tput setaf 2; echo 'Installing GUI utilities...'; tput sgr0;
pacman --noconfirm -S evince # pdf reader that supports .djvu format
pacman --noconfirm -S gnome-calculator # calculator
pacman --noconfirm -S gnome-terminal # terminal
pacman --noconfirm -S chromium # browser (another option: opera) 
pacman --noconfirm -S fcitx fcitx-configtool # input method
pacman --noconfirm -S gnome-screenshot shutter # screenshot
pacman --noconfirm -S xournal # pdf annotation/note
pacman --noconfirm -S leafpad # text editor
pacman --noconfirm -S eog eog-plugins # image viewer - eye of gnome
pacman --noconfirm -S stardict # dictionary
pacman --noconfirm -S dconf-editor # gnome-setting GUI tool
pacman --noconfirm -S file-roller # archive manager

pacman --noconfirm -S gnome-keyring # see below
# If applet is not prompting for a password when connecting to new wifi networks, and is just disconnecting immediately, you may need to install gnome-keyring.

pacman --noconfirm -S xfce4-clipman-plugin # clipman
pacman --noconfirm -S atril # pdf reader 

# install virtual box
pacman --noconfirm -S virtualbox qt4 virtualbox-host-dkms
modprobe vboxdrv
pacman --noconfirm -S wireshark-cli wireshark-qt # wireshark

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
GRANT ALL PRIVILEGES ON thoughts_ga6840.* TO 'thoughts_ga6840'@'%';
EOF
# install nginx
pacman --noconfirm -S nginx
systemctl start nginx
# install php-fpm
pacman --noconfirm -S php-fpm php-gd
systemctl start php-fpm
# patch /etc/nginx/nginx.conf to enble php handler
change_to=/root/arch-setup/nginx-php-config.txt
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
cp /root/arch-setup/test-php/* /usr/share/nginx/html
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

tput setaf 2; echo 'Configuring stardict...'; tput sgr0;
rm -rf /usr/share/stardict/dic
mkdir -p /usr/share/stardict/dic
cp "$cur_dir"/stardict-langdao-* /usr/share/stardict/dic/
pushd /usr/share/stardict/dic/
find . -maxdepth 1 -name 'stardict-langdao-*.bz2' -exec tar -xjf {} \;
popd 

tput setaf 2; echo 'Adding my-terminal.desktop...'; tput sgr0;
cat << EOF > /usr/share/applications/my-terminal.desktop
[Desktop Entry]
Name=My Terminal
Comment=Use the command line
Keywords=shell;prompt;command;commandline;
Exec=gnome-terminal -e "bash -c 'cd ~/Desktop;tmux;exec bash'"
Icon=utilities-terminal
Type=Application
Categories=GNOME;GTK;System;TerminalEmulator;
EOF

tput setaf 2; echo 'Creating user tk...'; tput sgr0; 
useradd -m -G wheel -s /bin/bash tk
while ! passwd tk; do :; done
usermod tk -a -G http
usermod tk -a -G vboxusers 
usermod tk -a -G wireshark

tput setaf 2; echo 'Configuring sudoer...'; tput sgr0; 
pacman --noconfirm -S sudo
echo 'tk ALL=(ALL:ALL) ALL' | (EDITOR="tee -a" visudo)

tput setaf 2; echo 'Copy custom-keybindings.dump...'; tput sgr0;
mkdir -p /var/tmp/
custom_keybindings=/var/tmp/custom-keybindings.dump
cp /root/arch-setup/custom-keybindings.dump ${custom_keybindings}
chown tk ${custom_keybindings} # enable tk to mv it

tput setaf 2; echo 'Replacing pannel icon...'; tput sgr0;
cp /root/arch-setup/arch-linux.svg /usr/share/cinnamon/theme/menu-symbolic.svg

tput setaf 2; echo 'Override gschema...'; tput sgr0;
cp /root/arch-setup/10_my-arch-setup.gschema.override /usr/share/glib-2.0/schemas/
glib-compile-schemas /usr/share/glib-2.0/schemas/
rm -f /home/tk/.config/dconf/user
rm -rf /home/tk/.cinnamon/

tput setaf 2; echo 'Overwrite Cinnamon panel-launchers...'; tput sgr0;
cp /root/arch-setup/launchers/settings-schema.json /usr/share/cinnamon/applets/panel-launchers\@cinnamon.org/settings-schema.json

tput setaf 2; echo 'Overwrite Cinnamon menu shortcut...'; tput sgr0;
sed -i -e 's/Super_L::Super_R//g' /usr/share/cinnamon/applets/menu@cinnamon.org/settings-schema.json

tput setaf 2; echo 'Writing .xinitrc...'; tput sgr0;
cat << EOF > /home/tk/.xinitrc
# Make Caps Lock an additional Esc
setxkbmap -option caps:escape
# (more options refer to :
# cat /usr/share/X11/xkb/rules/evdev.lst | grep swap_alt_win
# )

# dconf needs to run only once
if [ -e ${custom_keybindings} ]
then
	# You can dump keybindings by:
	# dconf dump /org/cinnamon/desktop/keybindings/
	dconf reset -f /org/cinnamon/desktop/keybindings/
	dconf load /org/cinnamon/desktop/keybindings/ < ${custom_keybindings}
	mv ${custom_keybindings} ${custom_keybindings}.finish
fi

# Config input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec cinnamon-session
EOF

# run as user tk:
sudo -u tk bash << EOF
tput setaf 2; echo 'Setup auto-start programs...'; tput sgr0;
mkdir -p /home/tk/.config/autostart/
# clipman
tmp=/usr/share/applications/xfce4-clipman.desktop
[ -e "\$tmp" ] && cp "\$tmp" /home/tk/.config/autostart/

tput setaf 2; echo 'Configuring bash_profile... '; tput sgr0; 
echo '[[ -z \$DISPLAY && \$XDG_VTNR -eq 1 ]] && exec startx' >> /home/tk/.bash_profile
# (if only has startx here, tmux would run into some problem)

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

tput setaf 2; echo 'Run my-arch-setup.sh'; tput sgr0;
"$cur_dir"/my-arch-setup.sh /usr/share/nginx/html http

tput setaf 2; echo 'Hand over network connection to NetworkManager...'; tput sgr0;
for i in `seq 9`
do
	killall -9 wpa_supplicant
done
systemctl enable NetworkManager.service
systemctl start NetworkManager.service

tput setaf 2; echo 'Reboot and login as tk!'; tput sgr0;
