#!/bin/bash
year=$(date +%Y)
rsync --progress -zauv --delete --exclude='.git/' ~/master-tree/incr/$year rsync://truenas:30026/rsync_root/master-tree/incr/
rsync --progress -zauv --delete --exclude='.git/' ~/master-tree/incr/install rsync://truenas:30026/rsync_root/master-tree/incr/
rsync --progress -zauv --delete --exclude='.git/' ~/master-tree/incr/materials rsync://truenas:30026/rsync_root/master-tree/incr/
