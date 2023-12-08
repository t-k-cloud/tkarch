pacmanS fcitx fcitx-configtool # input method

# fix chromium "losing char" problem when typing.
# You can diagnose using `fcitx-diagnose` command,
# you need to fix every red color warning except the
# "Fcitx Configure UI" section.
pacmanS extra/xorg-xprop
pacmanS fcitx-gtk2 fcitx-gtk3
pacmanS fcitx-qt5

cat << EOF >> /home/$USERNAME/.xinitrc
# Config input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

EOF
