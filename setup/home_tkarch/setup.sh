# copy tkarch from root to user home directory
user_tkarch_dest=/home/${USERNAME}/tkarch
rm -rf "$user_tkarch_dest"
rsync -a --chown=${USERNAME}:${USERNAME} /root/tkarch/ "$user_tkarch_dest"
