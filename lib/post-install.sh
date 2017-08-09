#!/bin/bash
TKARCH_DIR=$(cd `dirname $0`; pwd)/..
source ${TKARCH_DIR}/lib/common.sh

### make system bootable ###
pacmanS grub
setup grub_install

### locale, timezone and hostname ###
setup locale_gen
setup timezone
setup hostname

### NTP time sync ###
setup timesync

### root/user password ###
setup users
setup sudoer

### core packages ###
pacmanS iw wpa_supplicant
pacmanS git tmux vim rsync openssh
ln -sf `which vim` `which vi`

### desktop environment ###
if $DO_DESKTOP_ENV; then
	setup desktop_env
	setup desktop_utils
	setup gschema
	setup stardict
	setup my_terminal
	setup keybindings
	setup pannel_icon
	setup launcher
	setup input_method
	setup font
	setup autostart
	setup desktop_start
fi

### extra packages ###
#setup pacman_extra

### network hand-over ###
setup network_mg
