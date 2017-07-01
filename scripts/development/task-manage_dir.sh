#!/usr/bin/env bash

source ./utils.sh

delete_dir() {
    validate_env "FG_C" "WBG_C" "NO_C"

    if [ -d "$1" ]; then
        echo -e "${FG_C}${WBG_C} WARNING ${NO_C} You are about to delete $1 to install Contenta CMS in that location."
        rm -Rf $1
    fi
    if [ $? -ne 0 ]; then
         echo -e "${FG_C}${EBG_C} ERROR ${NO_C} Sometimes drush adds some files with permissions that are not deletable by the current user."
         echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} sudo rm -Rf $1"
         sudo rm -Rf $1
    fi


}
