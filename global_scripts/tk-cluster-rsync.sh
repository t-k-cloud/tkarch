#!/bin/bash
rsync -zauv --delete --exclude='.git/' ~/master-tree/ rsync://truenas:30026/rsync_root/master-tree/
