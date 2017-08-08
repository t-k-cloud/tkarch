jail_script=/usr/local/bin/jail.sh
jail_script_mnt=/mnt${jail_script}

cat << CHROOT > $jail_script_mnt
/root/tkarch/setup/mirrorlist/main.sh
/root/tkarch/lib/post-install.sh
CHROOT

chmod +x $jail_script_mnt
arch-chroot /mnt ${jail_script}
