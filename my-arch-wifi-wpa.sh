#!/bin/sh
wl_dev_nm=`iw dev | grep Interface | head -1 | grep -o 'w.*'`
tput setaf 2; echo wireless device name: $wl_dev_nm; tput sgr0; 
ip link set $wl_dev_nm up
iw dev $wl_dev_nm scan | grep SSID
tput setaf 2; echo 'enter SSID to connect:'; tput sgr0; 
read wl_ssid
tput setaf 2; echo 'enter wireless password:'; tput sgr0; 
read wl_passwd
wl_auth_cfg=/tmp/wl-tmp.cfg
tput setaf 2; echo "save config file @ $wl_auth_cfg"; tput sgr0; 
echo 'ctrl_interface=/run/wpa_supplicant' > $wl_auth_cfg
update_config=1 >> $wl_auth_cfg
wpa_passphrase "$wl_ssid" "$wl_passwd" >> $wl_auth_cfg
wpa_supplicant -B -i $wl_dev_nm -c $wl_auth_cfg 
dhcpcd $wl_dev_nm
