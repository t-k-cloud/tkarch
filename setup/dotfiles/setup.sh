# overwrite root dotfiles
/root/tkarch/dotfiles/overwrite.sh

# overwrite user dotfiles
sudo -u $USERNAME bash << EOF
/home/${USERNAME}/tkarch/dotfiles/overwrite.sh
EOF
