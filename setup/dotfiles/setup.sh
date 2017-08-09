# overwrite root dotfiles
/root/tkarch/dotfiles/overwrite.sh

# copy tkarch from root to user home directory
user_tkarch_dest=/home/${USERNAME}/tkarch
rm -rf "$user_tkarch_dest"
rsync -a --progress --chown=${USERNAME}:${USERNAME} /root/tkarch/ "$user_tkarch_dest"

# overwrite user dotfiles
sudo -u $USERNAME bash << EOF
$user_tkarch_dest/dotfiles/overwrite.sh
EOF
