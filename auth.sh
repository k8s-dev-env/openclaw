#!/bin/bash

touch .env
source .env

./openclaw.tty.sh models auth login --provider openai-codex
