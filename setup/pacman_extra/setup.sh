pacmanS \
	wget curl enca ctags expect dnsutils mlocate dosfstools parted \
	fuse-exfat exfat-utils python-pip mplayer htop imagemagick

pacmanS evince # pdf reader that supports .djvu format
pacmanS xournal # pdf annotation/note

# install proxy tools
pacmanS shadowsocks-libev polipo
cat << EOF > /etc/polipo/config
socksParentProxy = "localhost:3080"
socksProxyType = socks5
EOF
