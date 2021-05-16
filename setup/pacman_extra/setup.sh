pacmanS \
	wget curl enca ctags expect dnsutils mlocate dosfstools parted \
	fuse-exfat exfat-utils python-pip mplayer htop imagemagick nodejs npm

pacmanS evince # pdf reader that supports .djvu format
pacmanS xournal # pdf annotation/note

# install proxy tools
pacmanS shadowsocks-libev simple-obfs polipo
ln -sf /usr/bin/obfs-local /usr/local/bin/obfs-local
cat << EOF > /etc/polipo/config
socksParentProxy = "localhost:3080"
socksProxyType = socks5
EOF
