#!/bin/bash

# get the date with timezone Asia/Taipei (+8)
DATE=$(TZ=Asia/Taipei date +%Y%m%d-%H%M%S)
echo DATE: $DATE

# backup the .openclaw directory、.env、.ssh
tar -zcvf openclaw-data-$DATE.tar.gz .openclaw .env webtop
zip -e openclaw-data-$DATE.zip openclaw-data-$DATE.tar.gz
echo "openclaw-data backup saved to openclaw-data-$DATE.zip"