#!/bin/bash

WEBTOP_VERSION=ubuntu-kde-version-df170c95
OPENCLAW_VERSION=v2026.2.25

docker buildx build --no-cache --platform linux/amd64,linux/arm64 --push  -t r82wei/webtop-openclaw:${WEBTOP_VERSION}-${OPENCLAW_VERSION} .
docker buildx build --platform linux/amd64,linux/arm64 --push  -t r82wei/webtop-openclaw:latest .