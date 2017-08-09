pacmanS stardict

rm -rf /usr/share/stardict/dic
mkdir -p /usr/share/stardict/dic

cp ./stardict-langdao-* /usr/share/stardict/dic/

pushd /usr/share/stardict/dic/
find . -maxdepth 1 -name 'stardict-langdao-*.bz2' -exec tar -xjf {} \;
popd
