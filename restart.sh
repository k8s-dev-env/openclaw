#!/bin/bash

touch .env

source ./openclaw.env
source .env
source ./libs/openclaw.sh

restart_webtop_openclaw
