#!/bin/sh
. ./my-arch-ping.sh
is_connected || exit 

tput setaf 2; echo 'mounting disk...'; tput sgr0; 
mount /dev/sda4 /mnt
mkdir -p /mnt/boot
mount /dev/sda2 /mnt/boot

tput setaf 2; echo 'copy arch-setup scripts...'; tput sgr0;
cur_dir=$(cd `dirname $0`; pwd)
cp -r "$cur_dir" /root/arch-setup

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
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

tput setaf 2; echo 'locale gen...'; tput sgr0; 
cat << EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
EOF
locale-gen
echo 'LC_CTYPE="zh_CN.UTF-8"' > /etc/locale.conf # only applied to terminal.

tput setaf 2; echo 'please enter root passwd...'; tput sgr0; 
while ! passwd; do :; done
exit
CHROOT

chmod +x $jail_script_mnt

tput setaf 2; echo 'chroot...'; tput sgr0; 
arch-chroot /mnt ${jail_script} 

umount -R /mnt
tput setaf 2; echo 'you are good to reboot.'; tput sgr0; 
