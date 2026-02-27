# openclaw (webtop + openclaw)

Container setup for running OpenClaw on top of linuxserver/webtop.

## What this repo contains

- Docker build files under `Dockerfiles/webtop-openclaw/`
- Utility scripts for running and operating the stack

---

## 使用方法

### 0) 需求

- Linux + Docker
- 可拉取你要使用的 image（`WEBTOP_OPENCLAW_IMAGE`）

### 1) 啟動 Webtop（含 OpenClaw）

第一次啟動：

```bash
./start.sh
```

`start.sh` 會互動式詢問並建立 `.env`：
- `OPENCLAW_ID`
- `DASHBOARD_PORT`（預設 `18789`）
- `WEBTOP_HTTPS_PORT`（預設 `3001`）

並執行：
- 啟動 `webtop-openclaw-${OPENCLAW_ID}` 容器
- 啟動 OpenClaw Gateway（首次使用 `--allow-unconfigured`）
- 啟動 OpenClaw Node
- 執行 `openclaw onboard` 進行初始化

後續再次啟動同一環境：

```bash
./start.sh
```

常用操作：

```bash
./status.sh      # 檢查 nodes / openclaw 狀態
./restart.sh     # 重啟容器與 openclaw
./stop.sh        # 停止容器
./log.sh         # 查看日誌
./exec.sh        # 進入容器 shell
```

Web 介面：
- Webtop: `https://<host>:${WEBTOP_HTTPS_PORT}`（預設 `https://<host>:3001`）
- OpenClaw dashboard/gateway: `http://<host>:${DASHBOARD_PORT}`（預設 `http://<host>:18789`）

> 若使用自簽憑證，瀏覽器可能會先跳出安全警告，屬正常現象。

### 2) OpenClaw 初始化（onboard）

標準流程（建議）：
1. `./start.sh`（會自動帶你跑 `openclaw onboard`）
2. 完成 onboarding（同一個 gateway / 同一使用者 / 同一 state）
3. 確認服務狀態：`./status.sh`


### 3) Channel Pairing（DM / Chat channel）

配對流程：

```bash
./pairing-DM.sh
```

腳本會：
1. 先列出 `openclaw pairing list`
2. 要你輸入 Pairing code
3. 執行 `openclaw pairing approve <pairing_code>`

### 4) Device Pairing（裝置配對）

配對流程：

```bash
./pairing-devices.sh
```

腳本會：
1. 先列出 `openclaw devices list`（含 pending request）
2. 要你輸入 `request-id`
3. 執行 `openclaw devices approve <request-id>`

建議順序：
- 先完成 onboard
- 再做 channel/device pairing
- approve 後用 `./status.sh` 確認 `connected=true`

---

## Third-party licensing

This repository depends on third-party projects with their own licenses:

- linuxserver/webtop — GPL-3.0
- openclaw/openclaw — MIT

See:
- `THIRD_PARTY_LICENSES.md`
- `LICENSES/GPL-3.0-webtop.txt`
- `LICENSES/MIT-openclaw.txt`

## Project license

Unless otherwise noted, files in this repository are licensed under the MIT License. See `LICENSE`.

> Note: Distributed container images may include components under GPL-3.0 and other licenses. Review `THIRD_PARTY_LICENSES.md` for details.
