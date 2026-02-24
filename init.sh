#!/bin/bash

touch .env
source .env

if [ -z "$OPENCLAW_GATEWAY_TOKEN" ]; then
    # 自動產生
    OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)
    echo "OPENCLAW_GATEWAY_TOKEN=$OPENCLAW_GATEWAY_TOKEN" >> .env
fi

docker run -it --rm \
--env-file openclaw.env \
--env-file .env \
-v ./openclaw-data:/home/node/.openclaw \
--name openclaw \
-p 18789:18789 \
ghcr.io/openclaw/openclaw \
bash -c "node openclaw.mjs onboard"