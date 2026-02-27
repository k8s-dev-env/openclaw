#!/bin/bash

WEBTOP_VERSION=ubuntu-kde-version-df170c95
OPENCLAW_VERSION=v2026.2.25

docker buildx build --load --no-cache --build-arg WEBTOP_VERSION=${WEBTOP_VERSION} --build-arg OPENCLAW_VERSION=${OPENCLAW_VERSION} -t r82wei/webtop-openclaw:${WEBTOP_VERSION}-${OPENCLAW_VERSION} .
