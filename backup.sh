#!/bin/bash

source .env

# get the date with timezone Asia/Taipei (+8)
DATE=$(TZ=Asia/Taipei date +%Y%m%d-%H%M%S)
echo DATE: $DATE

# backup the .openclaw directory、.env、.ssh
sudo tar -zcvf openclaw-data.${OPENCLAW_ID}.$DATE.tar.gz .openclaw webtop .env 
zip -e openclaw-data.${OPENCLAW_ID}.$DATE.zip openclaw-data.${OPENCLAW_ID}.$DATE.tar.gz
echo "OpenClaw data backup saved to openclaw-data.${OPENCLAW_ID}.$DATE.zip"
rm -rf openclaw-data.${OPENCLAW_ID}.$DATE.tar.gz