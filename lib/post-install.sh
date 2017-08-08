#!/bin/bash
TKARCH_DIR=$(cd `dirname $0`; pwd)/..
source ${TKARCH_DIR}/lib/common.sh

pacmanS grub
setup grub_install
