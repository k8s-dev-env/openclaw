#!/bin/bash

source .env
source ./libs/openclaw.sh

# 執行 openclaw 命令，並且帶入所有參數
exec_tty_openclaw_command $@
