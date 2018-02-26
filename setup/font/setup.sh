pacmanS wqy-microhei # chinese font, Monospaced font included
pacmanS ttf-liberation # TTF font (otherwise MathJax is slow)
pacmanS ttf-droid # to be used as cinnamon default font to avoid Chromium address bar delay.
pacmanS community/ttf-inconsolata # monospaced font for programming


cat << EOF >> /home/$USERNAME/.xinitrc
# droid sans for Chromium address bar delay fix:
dconf reset -f /org/cinnamon/desktop/interface/
dconf write /org/cinnamon/desktop/interface/font-name "'Droid Sans Bold 9'"

EOF
