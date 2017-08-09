cat << EOF > /usr/share/applications/my-terminal.desktop
[Desktop Entry]
Name=My Terminal
Comment=Use the command line
Keywords=shell;prompt;command;commandline;
Exec=mate-terminal -e "bash -c 'cd ~/Desktop;tmux -2;exec bash'"
Icon=utilities-terminal
Type=Application
Categories=GNOME;GTK;System;TerminalEmulator;
EOF
