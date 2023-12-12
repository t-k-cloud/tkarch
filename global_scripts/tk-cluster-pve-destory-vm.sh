#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Examples:
$0 104 # destory pve-archlinux-vm104
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit
VMID=$1

status=$(qm status $VMID)
echo "$status"

if [ "$status" = "status: running" ]; then
	echo "stopping a running instance..."
	qm stop $VMID
fi

qm destroy $VMID
