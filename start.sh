#!/bin/bash


source ./openclaw.env
source ./libs/openclaw.sh

echo "WEBTOP_OPENCLAW_IMAGE=$WEBTOP_OPENCLAW_IMAGE"

if [ ! -d "./openclaw-data" ]; then
  echo "openclaw-data 資料夾不存在，需要初始化"

  # 建立 openclaw 資料夾
  mkdir -p ./openclaw-data
  chmod 777 ./openclaw-data

  # 啟動 webtop 容器
  run_webtop

  # 沒有 systemd：先用 --allow-unconfigured 起 gateway（還沒 onboard 也能跑），再跑 onboard
  run_openclaw_gateway_allow_unconfigured

  # 初始化 openclaw（此時 gateway 已在跑，Control UI / health check 可用）
  run_openclaw_onboard
else
  # 啟動 webtop 容器 & openclaw
  run_webtop_openclaw
fi

