# install cloud-init for cloud hypervisor like Proxmox in my case.
pacmanS cloud-init

CLOUD_CFG_DIR=/etc/cloud/cloud.cfg.d
CLOUD_CFG_FILE=10_datasource.cfg
mkdir -p $CLOUD_CFG_DIR

# add datasource(s) to cloud-init
cat << EOF > $CLOUD_CFG_DIR/$CLOUD_CFG_FILE
datasource_list: [ NoCloud, None ]
EOF

# Config files under /etc/cloud/cloud.cfg.d will be
# merged into the main config, the main config file
# is located at /etc/cloud/cloud.cfg
# which looks like below (with comments removed)
# ```
# users:
#   - default
# disable_root: true
# preserve_hostname: false
# system_info:
#   distro: arch
#   default_user:
#     name: arch
#     lock_passwd: True
#     gecos: arch Cloud User
#     groups: [wheel, users]
#     sudo: ["ALL=(ALL) NOPASSWD:ALL"]
#     shell: /bin/bash
#   paths:
#     cloud_dir: /var/lib/cloud/
#     templates_dir: /etc/cloud/templates/
#   ssh_svcname: sshd
# ```
# Explanation:
# The user is "default" which points to system_info default_user,
# which then is defined as "arch" with password SSH login disabled.
# The "disable_root" prohibit SSH login as root user (but sudo is set).
# And the "preserve_hostname: false" will ignore the /etc/hostname,
# and one can add a "hostname: myhostname" line to specify a hostname.

# Enable its systemd service to run "cloud-init init" at boot up.
# In the case of Proxmox at boot up, when a CD-ROM device (/dev/sr0)
# named "cidata" is attached to the virtual machine, and the mounted
# device contains files like "meta-data" and "user-data" (the latter
# has a magic file header line "#cloud-config") to pass in container
# as initialization parameters (according to the cloud-init protocol
# using the so-called "NoCloud" datasource).
# This has to happen before /run/media/<any>/cidata/ is automatically mounted.
systemctl enable cloud-init # start it on reboot

# do not trust the output of "cloud-init status",
# use systemd to check its status:
systemctl status cloud-init
# alternatively, go to the "cloud_dir" and check out the applied file to see
# if the expected datasource(s) or "*-data files" are adopted:
#
# cat /var/lib/cloud/instance/user-data.txt
# cat /var/lib/cloud/instance/datasource
# cat /var/lib/cloud/instance/cloud-config.txt
#
# which is a good way to inspect and debug.

# Reference
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_and_managing_cloud-init_for_rhel_9/configuring-cloud-init_cloud-content
