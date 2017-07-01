#!/usr/bin/env bash

source ./utils.sh

contentacms_download() {
    if [ -z "$1" ]; then
        echo -e "${FG_C}${EBG_C} ERROR ${NO_C} No path was passed for downloading Contenta CMS"
        exit 2
   else
        validate_env "COMPOSER" "FG_C" "EBG_C" "NO_C"
        echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} $COMPOSER create-project contentacms/contenta-jsonapi-project $1 --stability dev --no-interaction\n\n"

        $COMPOSER create-project contentacms/contenta-jsonapi-project $1 --stability dev --no-interaction --no-install

        if [ $? -ne 0 ]; then
            echo -e "${FG_C}${EBG_C} ERROR ${NO_C} There was a problem setting up Contenta CMS using composer."
            echo "Please check your composer configuration and try again."
            exit 2
        fi
   fi
}

contentacms_configure() {
   if [ -z "$1" ]; then
        echo -e "${FG_C}${EBG_C} ERROR ${NO_C} No path was passed for configuring Contenta CMS"
        exit 2
   else
        validate_env "COMPOSER" "BASE_DIR" "DOCROOT" "FG_C" "EBG_C" "NO_C"
        cd $1
        $COMPOSER config repositories.contenta_jsonapi path $BASE_DIR
        $COMPOSER require "contentacms/contenta_jsonapi:*" "phpunit/phpunit:~4.8" --no-progress
        cd $DOCROOT
   fi
}