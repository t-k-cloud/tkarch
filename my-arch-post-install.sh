#!/bin/sh
cur_dir=$(cd `dirname $0`; pwd)

. "$cur_dir"/my-arch-ping.sh
is_connected || exit 

tput setaf 2; echo 'Installing command line utilities...'; tput sgr0; 
pacman --noconfirm -S tmux curl vim ctags cscope flex bison 
pacman --noconfirm -S strace
pacman --noconfirm -S mlocate # updatedb/locate

tput setaf 2; echo 'Replace vi with vim...'; tput sgr0;
ln -sf `which vim` `which vi`

tput setaf 2; echo 'Installing desktop environment...'; tput sgr0;
pacman --noconfirm -S xorg-server xorg-xinit xterm # X server
pacman --noconfirm -S xf86-input-synaptics # touchpad/touchscreen
pacman --noconfirm -S adobe-source-han-sans-cn-fonts # chinese font
pacman --noconfirm -S cinnamon # desktop environment

tput setaf 2; echo 'Installing GUI utilities...'; tput sgr0;
pacman --noconfirm -S atril # pdf reader 
pacman --noconfirm -S gnome-calculator # calculator
pacman --noconfirm -S gnome-terminal # terminal
pacman --noconfirm -S chromium # browser
pacman --noconfirm -S fcitx fcitx-configtool # input method
pacman --noconfirm -S gnome-screenshot # screenshot
pacman --noconfirm -S xournal # pdf annotation/note
pacman --noconfirm -S leafpad # text editor
pacman --noconfirm -S eog eog-plugins # image viewer - eye of gnome
pacman --noconfirm -S stardict # dictionary
pacman --noconfirm -S dconf-editor # gnome-setting GUI tool
pacman --noconfirm -S file-roller # archive manager

pacman --noconfirm -S gnome-keyring # see below
# If applet is not prompting for a password when connecting to new wifi networks, and is just disconnecting immediately, you may need to install gnome-keyring.

pacman --noconfirm -S xfce4-clipman-plugin # clipman

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

cd /home/tk
git clone https://github.com/t-k-/homcf.git
./homcf/overwrite.sh
EOF

tput setaf 2; echo 'Setup root homcf.git...'; tput sgr0;
cd /root
git clone https://github.com/t-k-/homcf.git
./homcf/overwrite.sh

tput setaf 2; echo 'Hand over network connection to NetworkManager...'; tput sgr0;
for i in `seq 9`
do
	killall -9 wpa_supplicant
done
systemctl enable NetworkManager.service
systemctl start NetworkManager.service

tput setaf 2; echo 'You are good to login as tk!'; tput sgr0;
