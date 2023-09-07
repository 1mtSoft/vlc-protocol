#!/usr/bin/env bash

url=$(echo ${1:6} | sed 's/^https\/\//https:\/\//')
echo $url
file_name="${url##*/}"
file="${TMPDIR}${file_name}"
echo ${file}
echo $file_name

curl -k -v ${url} -o ${file}

/Applications/VLC.app/Contents/MacOS/VLC --vlm-conf ${file} &

exit
