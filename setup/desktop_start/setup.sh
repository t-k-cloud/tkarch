sudo -u $USERNAME bash << EOF
echo '[[ -z \$DISPLAY && \$XDG_VTNR -eq 1 ]] && exec startx' >> /home/${USERNAME}/.bash_profile
# (exec startx along, without [[]], will make tmux problematic)
EOF

cat << EOF >> /home/$USERNAME/.xinitrc
exec cinnamon-session

EOF
