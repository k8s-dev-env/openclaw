#!/bin/bash

# get the date with timezone Asia/Taipei (+8)
DATE=$(TZ=Asia/Taipei date +%Y%m%d-%H%M%S)
echo DATE: $DATE

# backup the openclaw-data directory、.env、.ssh
zip -e -r openclaw-data-$DATE.zip openclaw-data .env .ssh
echo "openclaw-data backup saved to openclaw-data-$DATE.zip"