#!/bin/sh
if [ -z $3 ]; then
cat << USAGE
Note:
This *MUST* be run as root in a arch-chroot environment.
Usage:
$0 <efi-device>
Default:
$0 sda1
USAGE
exit
fi

if [ ! -e /dev/$1 ]; then
	echo "/dev/$1 not presents"
	exit
fi

touch /root/test || exit

efi=$1

mkdir -p /boot/efi
mount /dev/$efi /boot/efi

rm -rf /boot/efi/EFI/arch_grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

cp /root/arch-setup/os_linux.icns /boot/efi/EFI/arch_grub/arch_grub.icns

echo "done."
echo "Now you should have a grub EFI entry when macbook-air reboots"
