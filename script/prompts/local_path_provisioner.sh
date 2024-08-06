#!/bin/bash

source ./prompts/messages.sh

prompt_local_path_provisioner() {
  local valid=false
  local choice
  local default_choice=1  # Default is true

  while [ "$valid" = false ]; do
    warning_message "Enable Local Path Provisioner:"
    echo "1) true"
    echo "2) false"
    echo -n -e "${warning_msg}Please enter the choice (default: $default_choice): ${reset}"
    read -r -n 1 choice
    echo # Move to the next line

    if [ -z "$choice" ]; then
      choice=$default_choice
    fi

    case "$choice" in
      1)
        local_path_provisioner_enabled=true
        valid=true
        ;;
      2)
        local_path_provisioner_enabled=false
        valid=true
        ;;
      *)
        warning_message "Invalid choice. Please select a valid number."
        ;;
    esac
  done
  export local_path_provisioner_enabled
  echo -e "${success_msg}Local Path Provisioner enabled: $local_path_provisioner_enabled${reset}"
}
