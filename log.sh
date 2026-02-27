#!/bin/bash

source .env

docker logs -f webtop-openclaw-${OPENCLAW_ID}
