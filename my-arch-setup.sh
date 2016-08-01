#!/bin/sh
[ ! $# -eq 2 ] && echo 'bad arg #.' && exit
http_root="$1"
http_user="$2"
proj_dir=/home/tk/tksync/proj

touch /root/test || exit
mkdir -p /usr/local/bin

echo "make sure Internet is connected and fast to use service: pip install, Github and Google/pepper-flash."
echo "run this script as follows:"
echo "./my-arch-setup.sh /usr/share/nginx/html http"
sleep 10

tput setaf 2; echo 'pip install packages...'; tput sgr0;
pip install feedparser # install feedparser
pip install pycurl # used by cowpie and tk-sched-show
pip install jieba whoosh # my blog search engine
# pacman --noconfirm -S sagemath # python2 math/ploting

# run as user tk:
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

tput setaf 2; echo 'Make package chromium-pepper-flash...'; tput sgr0;
cd /home/tk
git clone https://aur.archlinux.org/chromium-pepper-flash-dev.git
cd chromium-pepper-flash-dev/
makepkg -s 
EOF

tput setaf 2; echo 'Install package chromium-pepper-flash...'; tput sgr0;
cd /home/tk/chromium-pepper-flash-dev/
pacman --noconfirm -U *.pkg.tar.xz
# Don't forget to enable the Adobe Flash Player plugin on chrome://plugins/

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
echo "http_root: $http_root"
echo "http_user: $http_user"

ln -sf ${proj_dir}/tkblog ${http_root}/tkblog
sed -i -e "s/www-data/${http_user}/g" './tkscripts/tk-echo-httpd-user.sh'
tk-blog-rst-perm.sh
chmod 755 /home/tk/
curl http://127.0.0.1/tkblog/panel_.php?init=db

# Later, to import all blog into mysql, user can simply run: tk-blog-sync.sh local .
# And start index blog posts by using tk-blog-searchd.sh
