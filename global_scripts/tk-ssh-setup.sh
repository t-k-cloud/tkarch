#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Set local ssh for Github.
Examples:
$0
USAGE
exit
fi

# see https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

ssh-keygen -t rsa -b 4096 -C "clock126@126.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo "Paste public key below to your Github:"
cat ~/.ssh/id_rsa.pub
