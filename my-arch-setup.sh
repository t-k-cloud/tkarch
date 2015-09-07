#!/bin/sh
# run as user tk:
[ ! $# -eq 2 ] && echo 'bad arg #.' && exit
http_root="$1"
http_user="$2"
proj_dir=/home/tk/tksync/proj

touch /root/test || exit
mkdir -p /usr/local/bin

echo "http_root: $http_root"
echo "http_user: $http_user"

sudo -u tk bash << EOF
tput setaf 2; echo "cd to ${proj_dir}"; tput sgr0;
mkdir -p ${proj_dir}
cd ${proj_dir}

tput setaf 2; echo 'Clone git projects...'; tput sgr0;
git clone https://github.com/t-k-/homcf.git
git clone https://github.com/t-k-/one-script-feed-reader.git
git clone https://github.com/t-k-/tkblog.git
git clone https://github.com/t-k-/tkscripts.git

tput setaf 2; echo 'tk: home config...'; tput sgr0;
./homcf/overwrite.sh
EOF

tput setaf 2; echo "cd to ${proj_dir}"; tput sgr0;
cd ${proj_dir}
 
tput setaf 2; echo 'root: home config...'; tput sgr0;
cp -r ${proj_dir}/homcf /root/
/root/homcf/overwrite.sh

tput setaf 2; echo 'root: feed init...'; tput sgr0;
./one-script-feed-reader/init.sh

tput setaf 2; echo 'root: tkscripts init...'; tput sgr0;
./tkscripts/init.sh

tput setaf 2; echo 'root: tkblog init...'; tput sgr0;
ln -sf ${proj_dir}/tkblog ${http_root}/tkblog
sed -i -e "s/www-data/${http_user}/g" './tkscripts/tk-echo-httpd-user.sh'
tk-blog-rst-perm.sh
chmod 755 /home/tk/
curl http://127.0.0.1/tkblog/panel_.php?init=db
tk-blog-sync.sh local .
