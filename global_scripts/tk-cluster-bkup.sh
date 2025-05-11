#!/bin/bash
set -e
year=$(date +%Y)
tput bold setaf 1 && echo "local => nas" && tput sgr0
set -x
rsync --progress -zauv --delete --exclude='.git/' ~/master-tree/incr/$((year - 1)) rsync://truenas:30026/rsync_root/master-tree/incr/
rsync --progress -zauv --delete --exclude='.git/' ~/master-tree/incr/$year rsync://truenas:30026/rsync_root/master-tree/incr/
set +x

tput bold setaf 1 && echo "nas => local" && tput sgr0
set -x
rsync --progress -zauv --delete --exclude='.git/' rsync://truenas:30026/rsync_root/master-tree/proj/tkblog ~/master-tree/proj/
rsync --progress -zauv --delete --exclude='.git/' rsync://truenas:30026/rsync_root/master-tree/proj/hippo ~/master-tree/proj/
rsync --progress -zauv --delete --exclude='.git/' rsync://truenas:30026/rsync_root/master-tree/incr/materials ~/master-tree/incr/
set +x
