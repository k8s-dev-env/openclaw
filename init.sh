#!/bin/bash

touch .env
source .env

if [ -z "$OPENCLAW_GATEWAY_TOKEN" ]; then
    # 自動產生
    OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 32)
    echo "OPENCLAW_GATEWAY_TOKEN=$OPENCLAW_GATEWAY_TOKEN" >> .env
fi

source ./libs/openclaw.sh

run_openclaw
exec_openclaw_command onboard