#!/bin/bash
TKARCH_DIR=$(cd `dirname $0`; pwd)
source ${TKARCH_DIR}/lib/common.sh

### Prompt user to modify mirrorlist ###
setup mirrorlist

### Ensure we have Internet access ###
if $DO_CONN; then
	setup wifiwpa
fi;

pacman -Sy
pacmanS wget
internet || exit 

### Do dist partition ###
if $DO_PART; then
	setup diskpart
fi;

### Prepare jail environment ###
setup jail_mount

if $DO_JAIL_SETUP; then
	setup pacstrap # install stuffs in jail, this takes time!
	setup genfstab # better do only once, and outside of jail
fi;

pacmanS rsync
setup root_tkarch # copy tkarch to ./mnt/root

### Change root to jail and do jail-install ###
setup arch_chroot

echo 'Now remove USB drive and reboot.'
