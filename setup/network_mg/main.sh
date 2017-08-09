pacmanS networkmanager # NetworkManager.service

for i in `seq 9`
do
	killall -9 wpa_supplicant
done

systemctl enable NetworkManager.service
systemctl start NetworkManager.service
