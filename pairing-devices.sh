#!/bin/bash

touch .env

source openclaw.env
source .env
source ./libs/openclaw.sh

# approve openclaw device
pairing_openclaw_device