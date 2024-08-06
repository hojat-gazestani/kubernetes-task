#!/bin/bash

source ./script/prompts/00_messages.sh

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

# Function to prompt for cluster folder name
prompt_cluster_folder() {
  
  local default_folder="default_cluster"

  error_message "Cluster folder name not provided. I am going to exit.. " # TODO Use $CLUSTER_FOLDER instead of <local default_folder>
  echo -n -e "${warning_msg}Would you like to use the default folder name (${default_folder})? (Y/n): ${reset}"
  read -r use_default
  if [[ "$use_default" =~ ^([yY][eE][sS]|[yY])$ || -z "$use_default" ]]; then
    echo "$default_folder"
  else
    echo -n -e "${warning_msg}Please enter the cluster folder name: ${reset}"
    read -r -n 15 custom_folder
    if [ -z "$custom_folder" ]; then
      error_message "No cluster folder name provided. Exiting."
    fi
    echo "$custom_folder"
  fi
}