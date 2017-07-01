#!/usr/bin/env bash

source ./utils.sh

# Move up 3 levels since we are in contenta_jsonapi/script/development.
BASE_DIR="$(dirname $(dirname $(cd ${0%/*} && pwd)))"

COMPOSER="$(which composer)"
DOCROOT="web"

# Define the color scheme.
FG_C='\033[1;37m'
BG_C='\033[42m'
WBG_C='\033[43m'
EBG_C='\033[41m'
NO_C='\033[0m'
