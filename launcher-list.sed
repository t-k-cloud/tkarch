:my_tag
/"value":\ \[/,/\]/ {
	/]/! {
		$! {
			N;
			b my_tag;
		}
	}

	s/.*/\t"value": \[ \
\t    "org.gnome.gedit.desktop", \
\t    "stardict.desktop", \
\t    "gnome-calculator.desktop", \
\t    "org.gnome.Screenshot.desktop", \
\t    "my-terminal.desktop", \
\t    "chromium.desktop" \
\t]/;
}
