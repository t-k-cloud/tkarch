#!/bin/sh
# get connected to Internet first
./my-arch-wifi-wpa.sh

tput setaf 2; echo 'Installing command line utilities...'; tput sgr0; 
pacman --noconfirm -S tmux curl vim ctags cscope flex bison

tput setaf 2; echo 'Replace vi with vim...'; tput sgr0;
ln -sf `which vim` `which vi`

tput setaf 2; echo 'Make Caps Lock an additional Esc'; tput sgr0;
setxkbmap -option caps:escape
# (more options refer to :
# cat /usr/share/X11/xkb/rules/evdev.lst | grep swap_alt_win
# )

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

tput setaf 2; echo 'Installing dictionary...'; tput sgr0; 
rm -rf /usr/share/stardict/dic
mkdir -p /usr/share/stardict/dic
cp ./stardict-langdao-* /usr/share/stardict/dic/
pushd /usr/share/stardict/dic/
find . -maxdepth 1 -name 'stardict-langdao-*.bz2' -exec tar -xjf {} \;
popd 

tput setaf 2; echo 'Creating user tk...'; tput sgr0; 
useradd -m -G wheel -s /bin/bash tk
passwd tk

tput setaf 2; echo 'Configure his profile...'; tput sgr0; 
pacman --noconfirm -S sudo
echo 'tk ALL=(ALL:ALL) ALL' | (EDITOR="tee -a" visudo)

echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> /home/tk/.bash_profile
# (if only has startx here, tmux would run into some problem)

cat << EOF > /home/tk/.xinitrc
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec cinnamon-session
EOF

# run as user tk:
sudo -u tk bash << EOF
cd /home/tk
git clone https://github.com/t-k-/homcf.git
./homcf/overwrite.sh
EOF

tput setaf 2; echo 'Hand over network connection to NetworkManager...'; tput sgr0;
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
