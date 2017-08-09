cat << EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
EOF

locale-gen

echo 'LC_CTYPE="zh_CN.UTF-8"' > /etc/locale.conf
# notice: LC_CTYPE is only applied to terminal.
