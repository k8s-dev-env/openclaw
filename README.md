# openclaw (webtop + openclaw)

Container setup for running OpenClaw on top of linuxserver/webtop.

---

## English (Default)

### What this repo contains

- Docker build files under `Dockerfiles/webtop-openclaw/`
- Utility scripts for running and operating the stack

### 0) Requirements

- Linux + Docker
- Access to pull the target image (`WEBTOP_OPENCLAW_IMAGE`)

### 1) Start Webtop (with OpenClaw)

First run:

```bash
./start.sh
```

`start.sh` will prompt and create `.env` values:
- `OPENCLAW_ID`
- `DASHBOARD_PORT` (default `18789`)
- `WEBTOP_HTTPS_PORT` (default `3001`)

Then it will:
- Start `webtop-openclaw-${OPENCLAW_ID}` container
- Start OpenClaw Gateway (`--allow-unconfigured` for first-time setup)
- Start OpenClaw Node
- Run `openclaw onboard` for initialization

Later runs (same environment):

```bash
./start.sh
```

Common operations:

```bash
./status.sh      # Check nodes / openclaw status
./restart.sh     # Restart container and openclaw
./stop.sh        # Stop container
./log.sh         # View logs
./exec.sh        # Enter container shell
```

Web endpoints:
- Webtop: `https://<host>:${WEBTOP_HTTPS_PORT}` (default `https://<host>:3001`)
- OpenClaw dashboard/gateway: `http://<host>:${DASHBOARD_PORT}` (default `http://<host>:18789`)

> If self-signed certificates are used, browser security warnings are expected.

### 2) OpenClaw initialization (onboarding)

Recommended flow:
1. Run `./start.sh` (it will run `openclaw onboard` during first setup)
2. Complete onboarding with a stable gateway/user/state
3. Verify status with `./status.sh`

### 3) Channel pairing (DM / chat channel)

```bash
./pairing-DM.sh
```

This script will:
1. Show `openclaw pairing list`
2. Ask for pairing code
3. Run `openclaw pairing approve <pairing_code>`

### 4) Device pairing

```bash
./pairing-devices.sh
```

This script will:
1. Show `openclaw devices list` (including pending requests)
2. Ask for `request-id`
3. Run `openclaw devices approve <request-id>`

Suggested order:
- Finish onboarding first
- Then do channel/device pairing
- Verify `connected=true` via `./status.sh`

---

## 中文版

### 這個 repo 內容

- `Dockerfiles/webtop-openclaw/` 底下的 Docker build 檔案
- 一組啟動與維運腳本

### 0) 需求

- Linux + Docker
- 可以拉取目標 image（`WEBTOP_OPENCLAW_IMAGE`）

### 1) 啟動 Webtop（含 OpenClaw）

首次啟動：

```bash
./start.sh
```

`start.sh` 會互動式建立 `.env`：
- `OPENCLAW_ID`
- `DASHBOARD_PORT`（預設 `18789`）
- `WEBTOP_HTTPS_PORT`（預設 `3001`）

接著會：
- 啟動 `webtop-openclaw-${OPENCLAW_ID}` 容器
- 啟動 OpenClaw Gateway（首次使用 `--allow-unconfigured`）
- 啟動 OpenClaw Node
- 執行 `openclaw onboard` 完成初始化

後續同環境再次啟動：

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

> 若使用自簽憑證，瀏覽器出現安全警告屬正常。

### 2) OpenClaw 初始化（onboarding）

建議流程：
1. 執行 `./start.sh`（首次會跑 `openclaw onboard`）
2. 用固定 gateway/user/state 完成 onboarding
3. 使用 `./status.sh` 檢查狀態

### 3) Channel 配對（DM / chat channel）

```bash
./pairing-DM.sh
```

腳本會：
1. 顯示 `openclaw pairing list`
2. 要你輸入 pairing code
3. 執行 `openclaw pairing approve <pairing_code>`

### 4) Device 配對

```bash
./pairing-devices.sh
```

腳本會：
1. 顯示 `openclaw devices list`（含 pending）
2. 要你輸入 `request-id`
3. 執行 `openclaw devices approve <request-id>`

建議順序：
- 先完成 onboarding
- 再做 channel/device pairing
- 最後用 `./status.sh` 確認 `connected=true`

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
