#!/bin/bash

#docker run -d --env-file .env -v ./.openclaw:/home/node/.openclaw --name openclaw -p 18789:18789 node:24 bash -c "tail -f /dev/null"
#docker run -d --env-file .env -v ./.openclaw:/home/node/.openclaw --name openclaw -p 18789:18789 r82wei/openclaw:20260224-164504 bash -c "tail -f /dev/null"

mkdir -p ./openclaw-data
chmod 777 ./openclaw-data

docker run -d \
--env-file openclaw.env \
--env-file .env \
-v ./openclaw-data:/home/node/.openclaw \
--name openclaw \
-p 18789:18789 \
--shm-size=2gb \
--cap-add=SYS_ADMIN \
ghcr.io/openclaw/openclaw 
# r82wei/openclaw:latest

docker exec -u 0 openclaw bash -c 'apt update && apt install -y chromium'
docker exec -u 0 openclaw bash -c 'nohup /usr/bin/chromium \
  --headless=new \
  --no-sandbox \
  --disable-dev-shm-usage \
  --remote-debugging-address=127.0.0.1 \
  --remote-debugging-port=18800 \
  --user-data-dir=/tmp/chromium-profile \
  about:blank >/tmp/chromium.log 2>&1 & '