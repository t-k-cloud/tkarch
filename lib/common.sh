echo "tkarch dir: $TKARCH_DIR"

### read config file ###
cat ${TKARCH_DIR}/install.cfg
source ${TKARCH_DIR}/install.cfg

### install functions ###
function setup() {
	# print notice
	tput setaf 3;
	echo "setup [${1}]";
	tput sgr0;

	# exec this setup.
	pushd ${TKARCH_DIR}/setup/${1}
	source ./main.sh
	popd
}

function pacman() {
	# print notice
	tput setaf 3;
	echo "install list [$@]";
	tput sgr0;

	# pacman install package
	pacman --noconfirm -S $@
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
