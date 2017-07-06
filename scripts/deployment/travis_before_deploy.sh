#!/usr/bin/env bash

# Validate Environment Variable Function
# Validate that each value pass has an environment variable define, else exit with error
validate_env_var() {
    for var in $@
    do
        if [ -z "${!var}" ] ; then
            echo "Variable $var is not set" 1>&2
            exit 1
        fi
    done
}

# Set Deployment Variable Function
set_deploy_vars() {
    # Project Variables
    export PROJECT_NAME="${PROJECT_NAME:-ContentaCMS}"
    echo "PROJECT_NAME=$PROJECT_NAME"
    export PROJECT_BUILD_PATH="${PROJECT_BUILD_PATH:-$HOME/$PROJECT_NAME}"
    echo "PROJECT_BUILD_PATH=$PROJECT_BUILD_PATH"

    # Travis Variables
    export TRAVIS_BRANCH="${TRAVIS_BRANCH:-TAG}"
    echo "TRAVIS_BRANCH=$TRAVIS_BRANCH"
    export TRAVIS_BUILD_NUMBER="${TRAVIS_BUILD_NUMBER:-$(date +%s)}"
    echo "TRAVIS_BUILD_NUMBER=$TRAVIS_BUILD_NUMBER"
    export TRAVIS_BUILD_DIR="${TRAVIS_BUILD_DIR:-$PROJECT_BUILD_PATH}"
    echo "TRAVIS_BUILD_DIR=$TRAVIS_BUILD_DIR"

    # Custom tag name that may be used if travis build is not a tag
    export TAG_NAME="${PROJECT_NAME}_${TRAVIS_BRANCH}_release-$( date +%Y-%m-%d)_build_${TRAVIS_BUILD_NUMBER}"
    echo "TAG_NAME=$TAG_NAME"
    export TRAVIS_TAG="${TRAVIS_TAG:-$TAG_NAME}"
    echo "TRAVIS_TAG=$TRAVIS_TAG"
}

# Zip Folder Function
# This function receives two argument:
#   $1 -> Parent path of the folder that is going to be compressed
#   $2 -> Folder Name that is going to be compressed
#   $3 -> Zip Folder Name
zip_folder(){

    # Validate that 2 arguments were passed
    if [ -z "${!1}" ] || [ -z "${!2}" ] || [ -z "${!3}" ]; then
        echo "Please pass a parent folder path, the folder name and zip name to the zip_folder function" 1>&2
        exit 1
    fi

    validate_env_var TRAVIS_BUILD_DIR

    cd $1

    zip -r $TRAVIS_BUILD_DIR/$3.zip $2/*

    cd $TRAVIS_BUILD_DIR
}

# Remove Site Function
# This function receives one argument:
#   $1 -> The Drupal Base Path
rm_site(){
    if [ -z "${!1}" ] ; then
        echo "Please pass a Drupal Base Path to the rm_site function" 1>&2
        exit 1
    fi

    default_dir=$1/sites/default

    rm -rf $default_dir/settings.php \
           $default_dir/services.yml \
           $default_dir/files
}

$@