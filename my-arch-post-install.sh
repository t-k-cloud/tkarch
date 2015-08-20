#!/bin/sh
tput setaf 2; echo 'Installing command line utilities...'; tput sgr0; 
pacman --noconfirm -S git tmux curl vim ctags cscope flex bison

tput setaf 2; echo 'Installing GUI utilities...'; tput sgr0; 
pacman --noconfirm -S xorg-server xorg-xinit # X server
pacman --noconfirm -S xf86-input-synaptics # touchpad/touchscreen
pacman --noconfirm -S adobe-source-han-sans-cn-fonts # chinese font
pacman --noconfirm -S cinnamon # desktop environment
pacman --noconfirm -S atril # pdf reader 
pacman --noconfirm -S gnome-calculator # calculator
pacman --noconfirm -S xfce4-terminal # terminal
pacman --noconfirm -S chromium # browser
pacman --noconfirm -S fcitx fcitx-configtool # input method
pacman --noconfirm -S gnome-screenshot # screenshot
pacman --noconfirm -S xournal # pdf annotation/note
pacman --noconfirm -S gedit # text editor

pacman --noconfirm -S stardict # dictionary
rm -rf /usr/share/stardict/dic
mkdir -p /usr/share/stardict/dic

tput setaf 2; echo 'Creating user tk...'; tput sgr0; 
useradd -m -G wheel -s /bin/bash tk
passwd tk

pacman --noconfirm -S sudo
echo 'tk ALL=(ALL:ALL) ALL' | (EDITOR="tee -a" visudo)

echo 'startx' >> /home/tk/.bash_profile

cat << EOF > /home/tk/.xinitrc
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec cinnamon-session
EOF
