pacmanS ntp
systemctl enable ntpd.service
systemctl start ntpd.service
hwclock --systohc --utc # adjust hardware clock too
