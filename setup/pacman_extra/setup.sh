pacmanS \
	wget curl enca ctags expect dnsutils mlocate dosfstools parted \
	fuse-exfat exfat-utils python-pip mplayer htop imagemagick nodejs npm \
	man-db man-pages

pacmanS zathura-pdf-mupdf # using fast pdf engine and VI-like, supports history.
pacmanS xournal # pdf annotation/note

# install proxy tools
pacmanS shadowsocks-libev simple-obfs proxychains-ng
ln -sf /usr/bin/obfs-local /usr/local/bin/obfs-local
cat << EOF > /etc/proxychains.conf
strict_chain
proxy_dns
remote_dns_subnet 224
tcp_read_time_out 15000
tcp_connect_time_out 8000

[ProxyList]
socks5 127.0.0.1 3081
EOF
