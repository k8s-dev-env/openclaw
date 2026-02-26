#!/bin/bash

# 在本地啟動 webtop 容器
run_webtop() {
  if [ -z "$WEBTOP_OPENCLAW_IMAGE" ]; then
    read -p "Enter the webtop openclaw image: " WEBTOP_OPENCLAW_IMAGE
    if [ -z "$WEBTOP_OPENCLAW_IMAGE" ]; then
      echo "Error: webtop openclaw image is required"
      exit 1
    fi
    echo "WEBTOP_OPENCLAW_IMAGE=$WEBTOP_OPENCLAW_IMAGE" >> openclaw.env
  fi

  docker run -d \
    --env-file openclaw.env \
    --env-file .env \
    -e PUID=1000 \
    -e PGID=1000 \
    -v ./webtop:/config \
    -v ./openclaw-data:/config/.openclaw \
    -v ./obsidian:/config/obsidian \
    --name openclaw \
    -p 3000:3000 \
    -p 3001:3001 \
    --shm-size=2gb \
    --cap-add=SYS_ADMIN \
    --restart unless-stopped \
    ${WEBTOP_OPENCLAW_IMAGE}

  exec_bash_in_openclaw "while ! nc -z -w 3 localhost 3000; do echo 'Waiting for webtop to start...'; sleep 3; done"
}

run_openclaw() {
  # 啟動 openclaw gateway
  run_openclaw_gateway

  # 確定 openclaw gateway 啟動後，再啟動 openclaw node
  run_openclaw_node
}

# 啟動 openclaw gateway（需已有 config，例如 onboard 後）
run_openclaw_gateway() {
  exec_bash_in_openclaw "nohup openclaw gateway run &"
  exec_bash_in_openclaw "while ! nc -z -w 3 localhost 18789; do echo 'Waiting for gateway to start...'; sleep 3; done"
}

# 尚未 onboard、無 config 時也可啟動 gateway（供首次初始化用）
run_openclaw_gateway_allow_unconfigured() {
  exec_bash_in_openclaw "nohup openclaw gateway run --allow-unconfigured &"
  exec_bash_in_openclaw "while ! nc -z -w 3 localhost 18789; do echo 'Waiting for gateway to start...'; sleep 3; done"
}

# 確定 openclaw gateway 啟動後，再啟動 openclaw node
run_openclaw_node() {
  exec_bash_in_openclaw "nohup openclaw node run &"
}

run_webtop_openclaw() {
  run_webtop
  run_openclaw
}

stop_webtop_openclaw() {
  # 如果 openclaw 容器存在，則停止並刪除
  if docker ps -a | grep -q openclaw; then
    echo "$(docker stop openclaw) stopped"
    echo "$(docker rm openclaw) removed"
  fi
}

restart_webtop_openclaw() {
  stop_webtop_openclaw
  run_webtop_openclaw
}

reset_webtop_openclaw() {
  sudo rm -rf ./openclaw-data
  sudo rm -rf ./webtop
}

run_openclaw_onboard() {
  exec_bash_tty_in_openclaw openclaw onboard
}

run_openclaw_doctor_fix() {
  exec_bash_in_openclaw "openclaw doctor --fix"
}

pairing_openclaw_device() {
  exec_bash_in_openclaw "openclaw devices list"
  read -p "請輸入 request-id: " request_id
  exec_bash_in_openclaw "openclaw devices approve $request_id"
}

pairing_openclaw_DM() {
  exec_bash_in_openclaw "openclaw pairing list"
  read -p "請輸入 Pairing code: " pairing_code
  exec_bash_in_openclaw "openclaw pairing approve $pairing_code"
}

# 使用互動模式進入 openclaw 容器
exec_tty_in_openclaw() {
  docker exec -it openclaw bash
}

# 使用互動模式進入 openclaw 容器並以 root 執行
sudo_exec_tty_in_openclaw() {
  docker exec -it -u 0 openclaw bash
}

# 在 openclaw 容器內執行一段 shell 指令（傳入單一字串，可含 &&、>、& 等）
exec_bash_tty_in_openclaw() {
  echo "$*"
  docker exec -it openclaw bash -c 'eval "$1"' _ "$*"
}

# 在 openclaw 容器內以 root 執行一段 shell 指令（傳入單一字串，可含 &&、>、& 等）
sudo_exec_bash_tty_in_openclaw() {
  echo "$*"
  docker exec -it -u 0 openclaw bash -c 'eval "$1"' _ "$*"
}

# 在 openclaw 容器內執行一段 shell 指令（傳入單一字串，可含 &&、>、& 等）
exec_bash_in_openclaw() {
  echo "$*"
  docker exec openclaw bash -c 'eval "$1"' _ "$*"
}

# 在 openclaw 容器內以 root 執行一段 shell 指令（傳入單一字串，可含 &&、>、& 等）
sudo_exec_bash_in_openclaw() {
  echo "$*"
  docker exec -u 0 openclaw bash -c 'eval "$1"' _ "$*"
}

# 在 openclaw 容器內執行 openclaw 命令
exec_tty_openclaw_command() {
  echo "openclaw $@"
  docker exec -it openclaw bash -c 'openclaw "$@"' _ "$@"
}

# 在 openclaw 容器內以 root 執行 openclaw 命令
sudo_exec_tty_openclaw_command() {
  echo "openclaw $@"
  docker exec -it -u 0 openclaw bash -c 'openclaw "$@"' _ "$@"
}

# 在 openclaw 容器內執行 openclaw 命令
exec_openclaw_command() {
  echo "openclaw $@"
  docker exec openclaw bash -c 'openclaw "$@"' _ "$@"
}

# 在 openclaw 容器內以 root 執行 openclaw 命令
sudo_exec_openclaw_command() {
  echo "openclaw $@"
  docker exec -u 0 openclaw bash -c 'openclaw "$@"' _ "$@"
}