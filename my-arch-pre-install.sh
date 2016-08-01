#!/bin/sh
if [ -z $3 ]; then
cat << USAGE
Usage:
$0 <root-device> <boot-device> <grub-install-device>
Default:
$0 sda4 sda2 sda
USAGE
exit
fi

if [ ! -e /dev/$1 ]; then
	echo "/dev/$1 not presents"
	exit
fi

if [ ! -e /dev/$2 ]; then
	echo "/dev/$2 not presents"
	exit
fi

if [ ! -e /dev/$3 ]; then
	echo "/dev/$3 not presents"
	exit
fi

root=$1
boot=$2
grubinstall=$3

tput setaf 2; echo 'pre-install starts in 10s...'; tput sgr0;
echo "root: /dev/$root, boot: /dev/$boot, grub-install: /dev/$grubinstall"

tput setaf 2; echo 'Please modify mirror list for fast Internet speed before continue:'; tput sgr0;
tput setaf 2; echo '/etc/pacman.d/mirrorlist'; tput sgr0;
sleep 10

# start pre-install from here
cur_dir=$(cd `dirname $0`; pwd)
echo "current dir: ${cur_dir}"

echo "sourcing script..."
. "$cur_dir"/my-arch-ping.sh

echo "checking Internet connection..."
is_connected || exit 

tput setaf 2; echo 'mounting disk...'; tput sgr0; 
mount /dev/$root /mnt
mkdir -p /mnt/boot
mount /dev/$boot /mnt/boot

tput setaf 2; echo 'install the base system...'; tput sgr0; 
pacstrap /mnt base base-devel

tput setaf 2; echo 'generating fstab...'; tput sgr0; 
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

tput setaf 2; echo 'preparing post-script...'; tput sgr0; 
jail_script=/usr/local/bin/jail.sh
jail_script_mnt=/mnt${jail_script}

cat << CHROOT > $jail_script_mnt
tput setaf 2; echo 'install necessary commands...'; tput sgr0; 
pacman --noconfirm -S grub
pacman --noconfirm -S git 
pacman --noconfirm -S iw wpa_supplicant
pacman --noconfirm -S wget 

tput setaf 2; echo 'grub install...'; tput sgr0; 
grub-install --recheck /dev/$grubinstall
grub-mkconfig -o /boot/grub/grub.cfg

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
exit
CHROOT

chmod +x $jail_script_mnt

tput setaf 2; echo 'chroot...'; tput sgr0; 
arch-chroot /mnt ${jail_script} 

tput setaf 2; echo 'copy arch-setup scripts...'; tput sgr0;
cp -r "$cur_dir" /mnt/root/arch-setup

umount -R /mnt
tput setaf 2; echo 'remove USB drive and u are good to reboot.'; tput sgr0; 
