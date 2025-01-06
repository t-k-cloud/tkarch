#!/bin/bash
function get_vendor_ids() {
    for pci_addr in $(lspci -v | grep NVIDIA | awk '{print $1}'); do
        lspci -n -s $pci_addr | awk '{print $3}'
    done
}

vendor_ids=$(get_vendor_ids | tr '\n' ',' | head -c -1)

set -ex

cat << EOF > /etc/modules
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOF

echo "options kvm ignore_msrs=1" > /etc/modprobe.d/kvm.conf

echo "options vfio-pci ids=${vendor_ids} disable_vga=1"> /etc/modprobe.d/vfio.conf

update-initramfs -u

set +ex

echo "reboot to make it effective."
