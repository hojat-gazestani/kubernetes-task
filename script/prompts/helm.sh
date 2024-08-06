#!/bin/bash

source ./scprit/prompts/messages.sh

prompt_helm() {
  local valid=false
  local choice
  local default_choice=1  # Default is true

  while [ "$valid" = false ]; do
    warning_message "Enable Helm:"
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
        helm_enabled=true
        valid=true
        ;;
      2)
        helm_enabled=false
        valid=true
        ;;
      *)
        warning_message "Invalid choice. Please select a valid number."
        ;;
    esac
  done
  export helm_enabled
  echo -e "${success_msg}Helm enabled: $helm_enabled${reset}"
}
