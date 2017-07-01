#!/usr/bin/env bash

source ./import.sh

import_env $@

set_dest_dir $1

validate_env "DEST_DIR" "FG_C" "WBG_C" "NO_C" "BG_C"

if [ -z "$1" ] ; then
  echo -e "${FG_C}${WBG_C} WARNING ${NO_C} No installation path provided.\nContenta will be installed in $DEST_DIR."
  echo -e "${FG_C}${BG_C} USAGE ${NO_C} ${0} [install_path] # to install in a different directory."
fi


echo -e "\n\n\n"
echo -e "\t********************************"
echo -e "\t*   Installing Contenta CMS    *"
echo -e "\t********************************"
echo -e "\n\n\n"
echo -e "Installing to: $DEST_DIR\n"

delete_dir $DEST_DIR

echo "-----------------------------------------------"
echo " Downloading Contenta CMS using composer "
echo "-----------------------------------------------"

contentacms_download $DEST_DIR
contentacms_configure $DEST_DIR

echo "-----------------------------------------------"
echo " Installing Contenta CMS for local usage "
echo "-----------------------------------------------"
#echo -e "${FG_C}${BG_C} EXECUTING ${NO_C} $DRUSH si contenta_jsonapi --db-url=sqlite://sites/default/files/.ht.sqlite --account-pass=test -y\n\n"
#$DRUSH si contenta_jsonapi --db-url=sqlite://sites/default/files/.ht.sqlite --account-pass=test -y
#if [ $? -ne 0 ]; then
#  echo -e "${FG_C}${EBG_C} ERROR ${NO_C} The Drupal installer failed to install Contenta CMS."
#  exit 3
#fi
#
#echo -e "\n\n\n"
#echo -e "\t********************************"
#echo -e "\t*    Installation finished     *"
#echo -e "\t********************************"
#echo -e "\n\n\n"
