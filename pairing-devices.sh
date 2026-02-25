#!/bin/bash
# 用 host 網路啟動 OpenClaw，讓 CLI 與 Dashboard 的連線被視為 localhost，以便完成 device pairing。
# 使用方式：
#   1. 若已有 openclaw 容器在跑：docker stop openclaw && docker rm openclaw
#   2. ./start-pairing.sh
#   3. docker exec -it openclaw openclaw devices list
#   4. docker exec -it openclaw openclaw devices approve <request-id>
#   5. 完成後可改回 ./start.sh（bridge 模式）重啟，已核准的 device 會保留。

source ./libs/openclaw.sh

exec_bash_with_host_network "node openclaw.mjs devices list && \
    read -p "請輸入 request-id: " request_id && \
    echo "核准: node openclaw.mjs devices approve $request_id" && \
    node openclaw.mjs devices approve $request_id && \
    echo "核准完成"'
