#!/bin/sh
#!/bin/sh
if [ -z $3 ]; then
cat << USAGE
Usage:
$0 <root-device> <boot-device> <efi-device>
Default:
$0 sda4 sda2 sda1
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
efi=$3

# permission check
touch /root/test || exit

tput setaf 2; echo 'mounting EFI device'; tput sgr0; 
mount /dev/$root /mnt
mkdir -p /mnt/boot
mount /dev/$boot /mnt/boot
mkdir -p /mnt/boot/efi
mount /dev/$efi /mnt/boot/efi

tput setaf 2; echo 'clear old EFI entry'; tput sgr0; 
rm -rf /mnt/boot/efi/EFI/arch_grub

tput setaf 2; echo 'preparing jail-script...'; tput sgr0; 
jail_script=/usr/local/bin/jail.sh
jail_script_mnt=/mnt${jail_script}

cat << CHROOT > $jail_script_mnt
tput setaf 2; echo 'grub install (EFI) ...'; tput sgr0; 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
grub-mkconfig -o /boot/grub/grub.cfg

tput setaf 2; echo 'change EFI entry icon...'; tput sgr0; 
cp /root/arch-setup/os_linux.icns /boot/efi/EFI/arch_grub/arch_grub.icns
CHROOT

tput setaf 2; echo 'chroot...'; tput sgr0; 
arch-chroot /mnt ${jail_script} 

echo "done."
echo "Now you should have a grub EFI entry when macbook-air reboots"
