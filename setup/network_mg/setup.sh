# install network manager before we losing Internet
pacmanS networkmanager

# stop wireless network, if any.
if $DO_CONN; then
    for i in `seq 3`
    do
        killall -9 wpa_supplicant
    done
fi;

# hand over to NetworkManager.service
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
