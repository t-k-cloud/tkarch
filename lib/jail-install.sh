#!/bin/bash
TKARCH_DIR=$(cd `dirname $0`; pwd)/..
source ${TKARCH_DIR}/lib/common.sh

### make system bootable ###
pacmanS grub
setup grub_install

### when lack of confidence ###
if $REBOOT_TEST; then
	echo 'reboot to test booting.'
	exit
fi;

### core packages ###
pacmanS dhcpcd iw wpa_supplicant
pacmanS git tmux vim rsync
ln -sf `which vim` /usr/bin/vi

### Setup ssh/sshd ###
pacmanS openssh
systemctl enable sshd

### locale, timezone and hostname ###
setup locale_gen
setup timezone
setup hostname

### NTP time sync ###
setup timesync

### create user ###
setup users
setup sudoer
setup media_perm

### dotfiles and global scripts ###
setup home_tkarch
setup dotfiles
setup global_scripts

### desktop environment ###
if $DO_DESKTOP_ENV; then
	# install desktop env/utils
	setup desktop_env
	setup desktop_utils
	setup translator
	# styles and customization
	setup gschema
	setup my_terminal
	setup pannel_icon
	setup launcher
	setup autostart
	setup keybindings # write to ~/.xinitrc
	setup font # write to ~/.xinitrc
	# input methods
	setup input_method # write to ~/.xinitrc
	# finally, write "exec session" in ~/.xinitrc
	setup desktop_start
fi

### extra packages ###
setup nongui_utils
setup lemp_stack

### network hand-over ###
setup network_mg

### prompt user to enter root password */
passwd
