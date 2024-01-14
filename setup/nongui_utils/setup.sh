# here we only install non-GUI packages, install GUI commands in desktop_utils!
pacmanS \
	wget curl enca ctags expect dnsutils mlocate dosfstools parted \
	hwinfo fuse-exfat exfat-utils python-pip htop nodejs npm nfs-utils \
	man-db man-pages ncdu

# install docker
pacmanS docker
DOCKER_MIRROR=https://docker.io
mkdir -p /etc/docker
cat > '/etc/docker/daemon.json' << EOF
{
	"registry-mirrors": ["$DOCKER_MIRROR"],

	"log-driver": "json-file",
	"log-opts": {
		"max-size": "10m",
		"max-file": "3"
	},

	"metrics-addr" : "0.0.0.0:9323",
	"experimental" : true
}
EOF
# To get metrics: `curl 127.0.0.1:9323/metrics`
systemctl enable docker
