pacmanS fcitx fcitx-configtool # input method
pacmanS fcitx-gtk2 # fix chromium "losing char" problem when typing.

cat << EOF >> /home/$USERNAME/.xinitrc
# Config input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec cinnamon-session

EOF
