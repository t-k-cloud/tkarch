Steps
=====
1. use `./global_scripts/tk-mk-usb-boot.sh` to make a bootable USB stick.

2. `cd` to USB stick partition,

	* double-check if GRUB is installed by checking if `boot` folder is there

	* `git clone` this repo.

	* `wget archlinux-2021.05.01-x86_64` **and rename it** to `archlinux.iso`.

3. In `tkarch` folder on your USB stick, edit installation configuration file `install.cfg`, or
overwrite it using available template:

	* If you are using Macbook Air, overwrite it using `install.macbookair.cfg` template,
	but be sure you have the disk partition using rEFIt like this:
	
	```
	$ sudo fdisk -l /dev/sda
	Disk /dev/sda: 113 GiB, 121332826112 bytes, 236978176 sectors
	Disk model: APPLE SSD TS128E
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 4096 bytes
	I/O size (minimum/optimal): 4096 bytes / 4096 bytes
	Disklabel type: gpt
	Disk identifier: 8E072E23-229A-4F4E-A880-02BDB5339788

	Device        Start       End   Sectors   Size Type
	/dev/sda1        40    409639    409600   200M EFI System
	/dev/sda2    409640  30652631  30242992  14.4G Apple HFS/HFS+
	/dev/sda3  30652632  31922175   1269544 619.9M Apple boot
	/dev/sda4  31922176  32813055    890880   435M EFI System
	/dev/sda5  32813056  35155967   2342912   1.1G Linux swap
	/dev/sda6  35155968 236976127 201820160  96.2G Linux filesystem
	```

	* If you are not using Mac, overwrite it using `install.asus.cfg` template.

4. copy `tkarch/grub.cfg` to `boot/grub/grub.cfg`

5. boot into USB stick, select archlinux boot entry and login to Arch Linux installer.

6. in this installer, run `/run/archiso/img_dev/tkarch/install.sh`, you will be prompted to setup root password at the end.

7. now reboot and login as `root`, use `passwd <username>` to set password for the user.

8. exit root and login as the user.

Test Grub-Install
==================
Install as normal except we set `REBOOT_TEST=true` to test grub-install. 

If grub-install works (you can successfully boot into the newly installed partition), just set `DO_JAIL_SETUP=false` and `DO_PART=false` for the second run of `install.sh`.

From Archlinux ISO
==================
No need to make a grub-enabled USB-stick, just boot from the live ISO and
```sh
pacman-key --init
pacman -Sy archlinux-keyring
pacman -S git vim
git clone --depth 1 https://github.com/t-k-cloud/tkarch
cd tkarch
vim install.cfg # if you want to change HOSTNAME etc.
./install.sh
```

Run individual setup
==============
```sh
su # input your password
TKARCH_DIR=`pwd`
source lib/common.sh
setup translator
```
