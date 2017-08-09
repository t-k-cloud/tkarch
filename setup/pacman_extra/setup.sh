pacmanS \
	wget curl graphviz enca strace ctags cscope flex bison \
	expect dnsutils imagemagick mlocate dosfstools parted \
	fuse-exfat exfat-utils python-pip mplayer \

pacmanS evince # pdf reader that supports .djvu format
pacmanS xournal # pdf annotation/note

# install virtual box
pacmanS virtualbox qt4 virtualbox-host-dkms
pacmanS linux-headers # for kernel module
/usr/bin/rcvboxdrv # build kernel module and load vboxdrv

# install wireshark
pacmanS wireshark-cli wireshark-qt

# install proxy tools
pacmanS shadowsocks-libev polipo

mkdir -p /etc/polipo
cat << EOF > /etc/polipo/ss.json
{
    "server":"<ip>",
    "server_port":<port>,
    "local_port":3080,
    "password":"<passwd>",
    "timeout":60,
    "method":"aes-256-cfb"
}
EOF

cat << EOF > /etc/polipo/config
socksParentProxy = "localhost:3080"
socksProxyType = socks5
EOF
