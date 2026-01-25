#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
Compress PDF to match E-Book specs.

Examples:
$0 a.pdf
USAGE
exit
fi

[ $# -ne 1 ] && echo 'bad arg.' && exit

set -ex
tmp_file=$(mktemp)
mv "$1" $tmp_file
gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile="$1" $tmp_file
