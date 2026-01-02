mkdir -p $(dirname "$KEYBINDTMPFILE")
cp ./custom-keybindings.dump $KEYBINDTMPFILE
chown $USERNAME $KEYBINDTMPFILE # enable user to mv it

sed -i -e 's/Super_L::Super_R//g' /usr/share/cinnamon/applets/menu@cinnamon.org/settings-schema.json

cat << EOF >> /home/$USERNAME/.xinitrc
# Make Caps Lock an additional Esc
setxkbmap -option '' -v
setxkbmap -option caps:escape

# cinnamon has /usr/bin/csd-keyboard daemon resetting this xkb-options,
# it uses gsettings as ground-truth, so we'd better follow this practice:
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
gsettings set org.cinnamon.desktop.input-sources xkb-options "['caps:escape']"

if $ALT_ALSO_WIN; then
setxkbmap -option altwin:alt_win
fi;

# (more options refer to :
# cat /usr/share/X11/xkb/rules/evdev.lst | grep swap_alt_win
# )

# Load keybindings
# You can dump keybindings by:
# dconf dump /org/cinnamon/desktop/keybindings/
if [ -e $KEYBINDTMPFILE ]
then
	dconf reset -f /org/cinnamon/desktop/keybindings/
	dconf load /org/cinnamon/desktop/keybindings/ < $KEYBINDTMPFILE
	mv $KEYBINDTMPFILE ${KEYBINDTMPFILE}.finish
fi

EOF
