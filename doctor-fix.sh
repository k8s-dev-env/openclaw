#!/bin/bash

touch .env

source openclaw.env
source .env
source ./libs/openclaw.sh

run_openclaw_doctor_fix