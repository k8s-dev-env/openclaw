#!/bin/bash

# 在本地啟動 openclaw 容器
# 透過參數掛載資料夾路徑
run_openclaw() {
  docker run -d \
    --env-file openclaw.env \
    --env-file .env \
    -v ./openclaw-data:/home/node/.openclaw \
    -v ./.ssh:/home/node/.ssh \
    -v ./obsidian:/home/node/obsidian \
    --name openclaw \
    -p 18789:18789 \
    --shm-size=2gb \
    --cap-add=SYS_ADMIN \
    --restart unless-stopped \
    ghcr.io/openclaw/openclaw:latest
}

# 在 host 網路啟動 openclaw 容器並執行一段 shell 指令（傳入單一字串，可含 &&、>、& 等）
exec_bash_with_host_network() {
  local command="$1"
  
  docker run -it --rm \
    --env-file openclaw.env \
    --env-file .env \
    -v ./openclaw-data:/home/node/.openclaw \
    -v ./.ssh:/home/node/.ssh \
    --name openclaw-tmp \
    --network host \
    --shm-size=2gb \
    --cap-add=SYS_ADMIN \
    ghcr.io/openclaw/openclaw:latest \
    bash -c "$command"
}

# 使用互動模式進入 openclaw 容器
exec_in_openclaw() {
  docker exec -it openclaw bash
}

# 使用互動模式進入 openclaw 容器並以 root 執行
sudo_exec_in_openclaw() {
  docker exec -it -u 0 openclaw bash
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
exec_openclaw_command() {
  echo "openclaw $@"
  docker exec openclaw bash -c 'node openclaw.mjs "$@"' _ "$@"
}

# 在 openclaw 容器內以 root 執行 openclaw 命令
sudo_exec_openclaw_command() {
  echo "openclaw $@"
  docker exec -u 0 openclaw bash -c 'node openclaw.mjs "$@"' _ "$@"
}

stop_openclaw() {
  # 如果 openclaw 容器存在，則停止並刪除
  if docker ps -a | grep -q openclaw; then
    docker stop openclaw
    docker rm openclaw
  fi
}

start_openclaw() {
  docker start openclaw
}

restart_openclaw() {
  stop_openclaw
  run_openclaw
}