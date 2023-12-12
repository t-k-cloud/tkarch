# let symbol links be from /home tkarch instead of from /root tkarch!
/home/${USERNAME}/tkarch/systemd_services/init.sh /etc/systemd/system

chmod 664 /etc/systemd/system/*.service

for srv in $SERVICES; do
    echo "Enabling systemd service: $srv";
    systemctl enable $srv
done
