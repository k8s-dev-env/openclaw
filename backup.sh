#!/bin/bash

# get the date with timezone Asia/Taipei (+8)
DATE=$(TZ=Asia/Taipei date +%Y%m%d-%H%M%S)
echo DATE: $DATE

# backup the .openclaw directory、.env、.ssh
sudo tar -zcvf openclaw-data-$DATE.tar.gz .openclaw webtop .env 
zip -e openclaw-data-$DATE.zip openclaw-data-$DATE.tar.gz
echo "openclaw-data backup saved to openclaw-data-$DATE.zip"