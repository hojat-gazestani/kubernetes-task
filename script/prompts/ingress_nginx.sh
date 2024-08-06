#!/bin/bash

source ./prompts/messages.sh

prompt_ingress_nginx() {
  local valid=false
  local choice
  local default_choice=2  # Default is false

  while [ "$valid" = false ]; do
    warning_message "Enable Ingress NGINX:"
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
        ingress_nginx_enabled=true
        valid=true
        ;;
      2)
        ingress_nginx_enabled=false
        valid=true
        ;;
      *)
        warning_message "Invalid choice. Please select a valid number."
        ;;
    esac
  done
  export ingress_nginx_enabled
  echo -e "${success_msg}Ingress NGINX enabled: $ingress_nginx_enabled${reset}"
}
