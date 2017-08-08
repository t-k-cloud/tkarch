#!/bin/bash
TKARCH_DIR=$(cd `dirname $0`; pwd)
source ${TKARCH_DIR}/lib/common.sh

### install ###
setup mirrorlist

if $DO_CONN; then
	setup wifiwpa
fi;

internet || exit 

if $DO_PART; then
	setup diskpart
fi;

setup jail_mount
setup pacstrap
setup jail_genfstab
setup jail_tkarch
setup arch_chroot
