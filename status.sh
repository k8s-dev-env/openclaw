#!/bin/bash

touch .env

source openclaw.env
source .env
source ./libs/openclaw.sh

exec_bash_in_openclaw "openclaw nodes status"
exec_bash_in_openclaw "openclaw status --all"