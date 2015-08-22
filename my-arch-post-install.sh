#!/bin/sh
. ./my-arch-ping.sh
is_connected || exit 

tput setaf 2; echo 'Installing command line utilities...'; tput sgr0; 
pacman --noconfirm -S tmux curl vim ctags cscope flex bison 
pacman --noconfirm -S strace

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
pacman --noconfirm -S gedit # text editor
pacman --noconfirm -S eog eog-plugins # image viewer - eye of gnome
pacman --noconfirm -S stardict # dictionary
pacman --noconfirm -S dconf-editor # gnome-setting GUI tool

pacman --noconfirm -S gnome-keyring # see below
# If applet is not prompting for a password when connecting to new wifi networks, and is just disconnecting immediately, you may need to install gnome-keyring.

pacman --noconfirm -S xfce4-clipman-plugin # clipman

tput setaf 2; echo 'Installing dictionary...'; tput sgr0; 
rm -rf /usr/share/stardict/dic
mkdir -p /usr/share/stardict/dic
cp ./stardict-langdao-* /usr/share/stardict/dic/
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
passwd tk

tput setaf 2; echo 'Configuring sudoer...'; tput sgr0; 
pacman --noconfirm -S sudo
echo 'tk ALL=(ALL:ALL) ALL' | (EDITOR="tee -a" visudo)

mkdir -p /var/tmp/
tput setaf 2; echo 'Copy keybindings.dump...'; tput sgr0;
cp /root/arch-setup/keybindings.dump /var/tmp/
tput setaf 2; echo 'Copy launcher-list.sed...'; tput sgr0;
cp /root/arch-setup/launcher-list.sed /var/tmp/

tput setaf 2; echo 'Replacing pannel icon...'; tput sgr0;
cp /root/arch-setup/arch-linux.svg /usr/share/cinnamon/theme/menu-symbolic.svg

cat << EOF > /home/tk/.xinitrc
# Make Caps Lock an additional Esc
setxkbmap -option caps:escape
# (more options refer to :
# cat /usr/share/X11/xkb/rules/evdev.lst | grep swap_alt_win
# )

# dconf needs to run only once
if [ ! -e /var/tmp/my-arch-post-install.lock ]
then
	# Enable zoom / magnifier
	dconf write /org/cinnamon/desktop/a11y/applications/screen-magnifier-enabled "true"

	# Disable auto suspending / locking screen
	dconf write /org/cinnamon/desktop/screensaver/lock-enabled "false"
	dconf write /org/cinnamon/settings-daemon/plugins/power/button-power "'nothing'"
	dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-display-battery 0
	dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-display-ac 0
	dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
	dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"

	# Load key bindings
	# You can get keybindings.dump by:
	# dconf dump /org/cinnamon/desktop/keybindings/ > keybindings.dump
	dconf reset -f /org/cinnamon/desktop/keybindings/
	dconf load /org/cinnamon/desktop/keybindings/ < /var/tmp/keybindings.dump

	# Customize pannel
	dconf write /org/cinnamon/panels-resizable "['1:true']"
	dconf write /org/cinnamon/panels-height "['1:39']"

	# Set gnome-terminal default color scheme
	dconf reset -f /org/gnome/terminal/legacy/profiles:/
	uuid=\`gsettings get org.gnome.Terminal.ProfilesList default | grep -Po "(?<=').*(?=')"\`
	echo "uuid=[\${uuid}]" > /var/tmp/my-arch-post-install.lock
	dconf write /org/gnome/terminal/legacy/profiles:/:\${uuid}/background-color "'rgb(0,0,0)'"
	dconf write /org/gnome/terminal/legacy/profiles:/:\${uuid}/foreground-color "'rgb(170,170,170)'"
	dconf write /org/gnome/terminal/legacy/profiles:/:\${uuid}/use-theme-colors "false"

	# Overwriting panel-launchers
	sed_script=/var/tmp/launcher-list.sed
	find /home/tk/.cinnamon/configs/panel-launchers@cinnamon.org/ -name '*.json' -exec sed -i -f \$sed_script {} \\;

	# Remove show-desktop pannel applet
	echo "arr=\`dconf read /org/cinnamon/enabled-applets\`;" > /var/tmp/rm-show-desktop-applet.py
	echo "print(list(filter(lambda e: 'show-desktop' not in e , arr)))" >> /var/tmp/rm-show-desktop-applet.py
	dconf write /org/cinnamon/enabled-applets "\`python /var/tmp/rm-show-desktop-applet.py\`"

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

tput setaf 2; echo 'Hand over network connection to NetworkManager...'; tput sgr0;
for i in `seq 9`
do
	killall -9 wpa_supplicant
done
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
