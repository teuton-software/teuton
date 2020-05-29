#!/bin/bash

HOST=$1
PASSWORD=$2
FILENAME=$3

ftp -n $HOST <<EOF
quote USER anonymous
quote PASS $PASSWORD
bin
get $FILENAME
quit
EOF

if [ $? -eq 0 ]
then
  echo "[ftp] OK"
else
  echo "[ftp] ERROR"
fi
