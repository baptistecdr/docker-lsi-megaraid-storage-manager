#!/usr/bin/bash

echo "$ROOT_PASSWORD" | passwd root --stdin
/etc/init.d/vivaldiframeworkd start
/usr/local/MegaRAID\ Storage\ Manager/startupui.sh
