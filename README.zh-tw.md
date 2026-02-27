# openclaw（webtop + openclaw）

[English README](./README.md)

這個專案用來在 linuxserver/webtop 上執行 OpenClaw。

## 這個 repo 內容

- `Dockerfiles/webtop-openclaw/` 底下的 Docker build 檔案
- 一組啟動與維運腳本

## 0) 需求

- Linux + Docker
- 可以拉取目標 image（`WEBTOP_OPENCLAW_IMAGE`）

## 1) 啟動 Webtop（含 OpenClaw）

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

## 2) OpenClaw 初始化（onboarding）

建議流程：
1. 執行 `./start.sh`（首次會跑 `openclaw onboard`）
2. 用固定 gateway/user/state 完成 onboarding
3. 使用 `./status.sh` 檢查狀態

## 3) Channel 配對（DM / chat channel）

```bash
./pairing-DM.sh
```

腳本會：
1. 顯示 `openclaw pairing list`
2. 要你輸入 pairing code
3. 執行 `openclaw pairing approve <pairing_code>`

## 4) Device 配對

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

## 第三方授權

本專案相依以下第三方專案：

- linuxserver/webtop — GPL-3.0
- openclaw/openclaw — MIT

請參考：
- `THIRD_PARTY_LICENSES.md`
- `LICENSES/GPL-3.0-webtop.txt`
- `LICENSES/MIT-openclaw.txt`

## 專案授權

除另有標註外，本 repository 內檔案採 MIT License，請見 `LICENSE`。

> 注意：發佈的 container image 可能包含 GPL-3.0 或其他授權元件，請一併檢視 `THIRD_PARTY_LICENSES.md`。
