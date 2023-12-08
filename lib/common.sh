echo "tkarch dir: $TKARCH_DIR"

### read config file ###
cat ${TKARCH_DIR}/install.cfg
source ${TKARCH_DIR}/install.cfg

### common utility functions ###
function setup() {
	# print notice
	tput setaf 3;
	echo "setup ${1}";
	sleep 1
	tput sgr0;

	# exec this setup.
	pushd ${TKARCH_DIR}/setup/${1} > /dev/null
	(set -x
		 trap 'set +x; catch; set -x' ERR
		 catch() {
			tput setaf 1;
			echo "^-- One command may have failed.";
			echo "(pause 3 secs here)";
			tput sgr0;
			sleep 3
		 }
		 source ./setup.sh
	)
	popd > /dev/null
}

function pacmanS() {
	# pacman install package
	tput setaf 4;
	pacman --noconfirm -S $@
	tput sgr0;
}

function internet() {
	wget --spider http://www.baidu.com 2> /dev/null
	if [ $? -eq 0 ]; then
		echo 'Internet connected.'
		return 0;
	else
		echo 'Internet not connected.'
		return 1;
	fi
}
