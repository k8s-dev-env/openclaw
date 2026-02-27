#!/bin/bash

touch .env
source .env

docker logs -f webtop-openclaw-${OPENCLAW_ID}
