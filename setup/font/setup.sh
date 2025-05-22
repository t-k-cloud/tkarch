pacmanS wqy-microhei # Chinese font, Monospaced font included
pacmanS poppler-data # essential Chinese fonts for some PDFs
pacmanS ttf-liberation # TTF font (otherwise MathJax is slow)
pacmanS ttf-droid # to be used as cinnamon default font to avoid Chromium address bar delay.
pacmanS ttf-inconsolata # monospaced font for programming
pacmanS libertinus-font # for math font
pacmanS noto-fonts-emoji # for emoji
pacmanS ttf-jetbrains-mono-nerd # for many icons

cat << EOF >> /home/$USERNAME/.xinitrc
# droid sans for Chromium address bar delay fix:
dconf reset -f /org/cinnamon/desktop/interface/
dconf write /org/cinnamon/desktop/interface/font-name "'Droid Sans Bold 9'"
EOF
