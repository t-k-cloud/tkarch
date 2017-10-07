rm -rf /mnt/root/tkarch
# rsync -a --exclude='.git/' "$TKARCH_DIR/" /mnt/root/tkarch
rsync -a "$TKARCH_DIR/" /mnt/root/tkarch
