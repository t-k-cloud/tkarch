#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
toggle (enable/disable) touchpad.
Examples:
$0
USAGE
exit
fi

dconf_path="/org/cinnamon/settings-daemon/peripherals/touchpad/touchpad-enabled"
cur_value=`dconf read ${dconf_path}`

echo "current enable: ${cur_value}"

if [ "${cur_value}" == "false" ]; then
	dconf write ${dconf_path} "true" 
	echo "now enable it"
else
	dconf write ${dconf_path} "false"
	echo "now disable it"
fi
