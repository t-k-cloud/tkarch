#!/bin/sh
parted /dev/sda --script print 

sectors=`blockdev --getsize /dev/sda`
tput setaf 2; echo "sda has $sectors sectors in total, erase in 10 sec..."; tput sgr0; 
sleep 10
tput setaf 2; echo "sda: erase disk head ..."; tput sgr0; 
dd if=/dev/zero of=/dev/sda bs=512 count=8192
tput setaf 2; echo "sda: erase disk tail ..."; tput sgr0; 
dd if=/dev/zero of=/dev/sda bs=512 seek=`expr $sectors - 8192` count=8192

# GPT table creation 
parted /dev/sda --script mklabel gpt 
# 2M grub loader 
parted /dev/sda --script mkpart primary 1MiB 3MiB 
parted /dev/sda --script name 1 my_grub 
parted /dev/sda --script set 1 bios_grub on 
# 128M boot partition
parted /dev/sda --script mkpart primary 3MiB 131MiB 
parted /dev/sda --script name 2 my_boot 
# 512M swap partition
parted /dev/sda --script mkpart primary 131MiB 643MiB 
parted /dev/sda --script name 3 my_swap
# root partition for the rest of the disk
parted /dev/sda --script mkpart primary 643MiB -- -1MiB 
parted /dev/sda --script name 4 my_root
# mark EFI System Partition 
parted /dev/sda --script set 2 boot on 

tput setaf 2; echo 'making filesystem...'; tput sgr0; 
mkfs.vfat /dev/sda1
mkfs.ext4 -F /dev/sda2
mkswap -f /dev/sda3
swapon /dev/sda3
mkfs.ext4 -F /dev/sda4

tput setaf 2; echo 'resulting parition:'; tput sgr0; 
parted /dev/sda --script print 
