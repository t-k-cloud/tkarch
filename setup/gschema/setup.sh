# Install wallpaper for /usr/share/backgrounds/archlinux/simple.png
pacmanS archlinux-wallpaper

# generate compiled schemas for dconf on entering desktop env
cp ./10_tkarch.gschema.override /usr/share/glib-2.0/schemas/
glib-compile-schemas /usr/share/glib-2.0/schemas/
rm -f /home/${USERNAME}/.config/dconf/user
rm -rf /home/${USERNAME}/.cinnamon/
