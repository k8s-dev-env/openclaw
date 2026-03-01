#!/bin/bash

touch .env

source ./openclaw.env
source .env
source ./libs/openclaw.sh

echo "WEBTOP_OPENCLAW_IMAGE=$WEBTOP_OPENCLAW_IMAGE"

if [ ! -d "./.openclaw" ]; then
  echo ".openclaw 資料夾不存在，需要初始化"

  # 建立 openclaw 資料夾
  mkdir -p ./.openclaw
  chmod 777 ./.openclaw

  # 設定 openclaw ID，用於容器名稱
  read -p "請輸入 openclaw ID (留空則隨機生成，可自行到 .env 修改): " OPENCLAW_ID
  if [ -z "$OPENCLAW_ID" ]; then
    # 隨機生成 openclaw ID
    OPENCLAW_ID=$(openssl rand -hex 8)
  fi
  echo "OPENCLAW_ID=$OPENCLAW_ID" >> .env

  # 設定 Dashboard Port
  read -p "請輸入 Dashboard Port (留空則使用預設值 18789，可自行到 .env 修改): " DASHBOARD_PORT
  if [ -z "$DASHBOARD_PORT" ]; then
    DASHBOARD_PORT=18789
  fi
  echo "DASHBOARD_PORT=$DASHBOARD_PORT" >> .env

  # 設定 Webtop Port
  read -p "請輸入 Webtop https Port (留空則使用預設值 3001，可自行到 .env 修改): " WEBTOP_HTTPS_PORT
  if [ -z "$WEBTOP_HTTPS_PORT" ]; then
    WEBTOP_HTTPS_PORT=3001
  fi
  echo "WEBTOP_HTTPS_PORT=$WEBTOP_HTTPS_PORT" >> .env

  # 是否啟用 docker socket 掛載
  read -p "是否啟用 docker socket 掛載 (Y/n): " ENABLE_DOCKER_SOCKET
  if [ "$ENABLE_DOCKER_SOCKET" == "Y" || "$ENABLE_DOCKER_SOCKET" == "y" ]; then
    echo "ENABLE_DOCKER_SOCKET=Y" >> .env
    echo "MOUNT_DOCKER_SOCKET=/var/run/docker.sock:/run/docker.sock:ro" >> .env
  else
    echo "ENABLE_DOCKER_SOCKET=N" >> .env
  fi

  # 啟動 webtop 容器
  run_webtop

  # 沒有 systemd：先用 --allow-unconfigured 起 gateway（還沒 onboard 也能跑），再跑 onboard
  run_openclaw_gateway_allow_unconfigured

  # 啟動 openclaw node
  run_openclaw_node

  # 初始化 openclaw（此時 gateway 已在跑，Control UI / health check 可用）
  run_openclaw_onboard

  echo "openclaw 初始化完成"
  echo "如果需要配對 DM (pairing code)，請執行 ./pairing-DM.sh，並輸入 pairing code"
  echo "如果需要配對裝置，請執行 ./pairing-devices.sh，並輸入 request-id"
else
  # 啟動 webtop 容器 & openclaw
  run_webtop_openclaw
fi

echo "openclaw 啟動完成"