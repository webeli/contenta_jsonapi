#!/usr/bin/env bash

# Import  all task scripts

# Import Utility scrips
source ./utils.sh

for task_file in $(cd $(dirname "$0") && pwd)/task-*.sh; do
    source $task_file
done

import_env

