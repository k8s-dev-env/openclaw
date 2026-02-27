#!/bin/bash

touch .env

source ./openclaw.env
source .env
source ./libs/openclaw.sh

stop_webtop_openclaw
reset_webtop_openclaw
