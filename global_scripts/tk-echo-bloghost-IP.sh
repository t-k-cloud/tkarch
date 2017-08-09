#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
echo remote blog host IP address.
Examples:
$0
USAGE
exit
fi

echo 45.79.73.243
