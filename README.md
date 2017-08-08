STEPS
=====
1. use `tk-mk-usb-boot.sh` to make a bootable USB stick.

2. `cd` to USB stick partition,

	* check if a GRUB `boot` folder is already there

	* `git clone` this repo

	* `wget` a `archlinux-20**.**.**-x86_64.iso` **and rename it** to `archlinux.iso`.

3. copy `tkarch/grub.cfg` to `boot/grub/grub.cfg`

4. boot into USB stick, select archlinux boot entry and login to Arch Linux installer.

5. In this installer, USB stick partition is located in `/run/archiso/img_dev`.
   `cd` to its tkarch directory.

	* use `my-arch-wifi-spa.sh` to connect to a WPA encrypted WIFI hotspot.

	* use `my-arch-diskpart` to erase entire disk and make partitions.

	* issue `my-arch-pre-install.sh sda4 sda2 sda` to install base system.
	 (edit `/etc/pacman.d/mirrorlist` for faster download in China)

6. if installing on Macbook Air, further run `my-arch-mid-install-macbookair.sh` to setup grub EFI boot.

7. remove USB stick and reboot, then login to hard-disk Arch Linux system as root.
   `cd` to `/root/tkarch/tkarch`, use `my-arch-wifi-spa.sh` to get connected to WIFI again,
   then run `my-arch-post-install.sh`. Upon finish, reboot again.

8. Now login as `tk`.
