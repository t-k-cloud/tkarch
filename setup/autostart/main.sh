sudo -u $USERNAME bash << EOF
d=/home/$USERNAME/.config/autostart/
mkdir -p "\$d"

# clipman
tmp=/usr/share/applications/xfce4-clipman.desktop
[ -e "\$tmp" ] && cp "\$tmp" "\$d"
EOF
