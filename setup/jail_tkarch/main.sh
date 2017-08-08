rm -rf /mnt/root/tkarch
rsync -a --progress --exclude='.git/' "$TKARCH_DIR/" /mnt/root/tkarch
