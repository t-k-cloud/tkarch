mkdir -p $(dirname "$KEYBINDTMPFILE")
cp ./custom-keybindings.dump $KEYBINDTMPFILE
chown $USERNAME $KEYBINDTMPFILE # enable user to mv it

sed -i -e 's/Super_L::Super_R//g' /usr/share/cinnamon/applets/menu@cinnamon.org/settings-schema.json

cat << EOF >> /home/$USERNAME/.xinitrc
# Make Caps Lock an additional Esc
setxkbmap -option caps:escape

# Uncomment below for macbook air
#setxkbmap -option altwin:swap_alt_win

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
