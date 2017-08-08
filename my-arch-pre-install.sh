#!/bin/sh

tput setaf 2; echo 'install necessary commands...'; tput sgr0; 
pacman --noconfirm -S git 
pacman --noconfirm -S iw wpa_supplicant
pacman --noconfirm -S wget 

tput setaf 2; echo 'locale gen...'; tput sgr0; 
cat << EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
EOF
locale-gen
echo 'LC_CTYPE="zh_CN.UTF-8"' > /etc/locale.conf # only applied to terminal.

tput setaf 2; echo 'set timezone...'; tput sgr0;
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

tput setaf 2; echo 'please enter host name...'; tput sgr0; 
read this_hostname
echo "\$this_hostname" > /etc/hostname

tput setaf 2; echo 'please enter root passwd...'; tput sgr0; 
while ! passwd; do :; done
