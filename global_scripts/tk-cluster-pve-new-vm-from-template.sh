#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Examples:
$0 100 # shallow clone from 100
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit
SRC_VMID=$1

# clone the template
NEXT_VM_ID=$(pvesh get /cluster/nextid)
qm clone $SRC_VMID $NEXT_VM_ID --full false --name pve-tkarch-vm${NEXT_VM_ID}
VM_ID=$NEXT_VM_ID

# setup cloud-init parameters
qm set $VM_ID --ide2 local-lvm:cloudinit # attach cloud-init CD-ROM
qm set $VM_ID --sshkey ~/.ssh/id_rsa.pub # use the host key for SSH
qm set $VM_ID --ciupgrade 0 # avoid upgrade on system boot up
qm cloudinit dump $VM_ID user # see the applied user-data

# start vm
qm start $VM_ID
