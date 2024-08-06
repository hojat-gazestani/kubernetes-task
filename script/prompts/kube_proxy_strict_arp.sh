#!/bin/bash

source ./script/prompts/messages.sh

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

prompt_kube_proxy_strict_arp() {
  local valid=false
  local choice
  local default_choice=true  # Default is true

  while [ "$valid" = false ]; do
    warning_message "Set kube_proxy_strict_arp:"
    echo "1) true"
    echo "2) false"
    echo -n -e "${warning_msg}Please enter the choice (default: $default_choice): ${reset}"
    read -r -n 1 choice
    echo # Move to the next line

    # If no choice is entered, use the default
    if [ -z "$choice" ]; then
      choice=1  # Default to true
    fi

    case "$choice" in
      1)
        kube_proxy_strict_arp=true
        valid=true
        ;;
      2)
        kube_proxy_strict_arp=false
        valid=true
        ;;
      *)
        warning_message "Invalid choice. Please select a valid number."
        ;;
    esac
  done
  export kube_proxy_strict_arp
  echo -e "${success_msg}kube_proxy_strict_arp set to: $kube_proxy_strict_arp${reset}"
}

# prompt_kube_proxy_strict_arp