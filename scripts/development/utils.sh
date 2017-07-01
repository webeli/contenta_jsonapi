#!/usr/bin/env bash


validate_env() {
    for var in $@
    do
        if [ -z "${!var}" ] ; then
            echo "Variable $var is not set" 1>&2
            exit 1
        fi
    done
}

# Import all common use Environment Variables
import_env() {
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

   load_env_file
}

# Load .env files
load_env_file() {
    validate_env "BASE_DIR"

    export $(cat "$BASE_DIR/.env" | xargs)

    if [ -e .env.local ] ; then
        export $(cat .env.local | xargs)
    fi
}

# Set the DEST_DIR variable
set_dest_dir() {
    if [ $1 ] ; then
        DEST_DIR="$1"
    else
        validate_env "BASE_DIR"
        DEST_DIR="$( dirname $BASE_DIR )/test_contenta_jsonapi"
    fi
}

# Set DRUSH Variable
set_drush_env() {
    if [ $1 ] ; then
        DRUSH="$1"
    else
        validate_env "DEST_DIR"
        DRUSH="$DEST_DIR/bin/drush"
    fi
}
