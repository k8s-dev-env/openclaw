# openclaw (webtop + openclaw)

[繁體中文說明 (Traditional Chinese)](./README.zh-tw.md)

Container setup for running OpenClaw on top of linuxserver/webtop.

## What this repo contains

- Docker build files under `Dockerfiles/webtop-openclaw/`
- Utility scripts for running and operating the stack

## 0) Requirements

- Linux + Docker
- Access to pull the target image (`WEBTOP_OPENCLAW_IMAGE`)

## 1) Start Webtop (with OpenClaw)

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

## 2) OpenClaw initialization (onboarding)

Recommended flow:
1. Run `./start.sh` (it will run `openclaw onboard` during first setup)
2. Complete onboarding with a stable gateway/user/state
3. Verify status with `./status.sh`

## 3) Channel pairing (DM / chat channel)

```bash
./pairing-DM.sh
```

This script will:
1. Show `openclaw pairing list`
2. Ask for pairing code
3. Run `openclaw pairing approve <pairing_code>`

## 4) Device pairing

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
