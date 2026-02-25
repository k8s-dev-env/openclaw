#!/bin/bash

mkdir -p ./openclaw-data
chmod 777 ./openclaw-data

source ./libs/openclaw.sh

run_openclaw

sudo_exec_bash_in_openclaw "apt update && apt install -y jq chromium"
sudo_exec_bash_in_openclaw "nohup /usr/bin/chromium \
  --headless=new \
  --no-sandbox \
  --disable-dev-shm-usage \
  --remote-debugging-address=127.0.0.1 \
  --remote-debugging-port=18800 \
  --user-data-dir=/tmp/chromium-profile \
  about:blank >/tmp/chromium.log 2>&1 &"