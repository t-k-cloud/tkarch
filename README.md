STEPS
=====
1. use `tk-mk-usb-boot.sh` to make a bootable USB stick.

2. `cd` to USB stick partition,

	* check if a GRUB `boot` folder is already there

	* `git clone` this repo, edit and config `install.cfg`

	* `wget` a `archlinux-20**.**.**-x86_64.iso` **and rename it** to `archlinux.iso`.

3. copy `tkarch/grub.cfg` to `boot/grub/grub.cfg`

4. boot into USB stick, select archlinux boot entry and login to Arch Linux installer.

5. in this installer, run `/run/archiso/img_dev/tkarch/install.sh`.

6. if installing on Macbook Air, further run `my-arch-mid-install-macbookair.sh` to setup grub EFI boot.

7. now reboot and login as `root`, use `passwd <username>` to set password for the user.

8. login as the user.
