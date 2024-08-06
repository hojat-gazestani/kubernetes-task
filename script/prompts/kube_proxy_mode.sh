#!/bin/bash

source ./script/prompts/messages.sh

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

prompt_kube_proxy_mode() {
  local valid=false
  local choice
  local default_choice=1  # Default is ipvs

  while [ "$valid" = false ]; do
    warning_message "Choose kube_proxy_mode by number:"
    echo "1) ipvs"
    echo "2) iptables"
    echo -n -e "${warning_msg}Please enter the number of the kube_proxy_mode (default: $default_choice): ${reset}"
    read -r -n 1 choice
    echo # Move to the next line

    # If no choice is entered, use the default
    if [ -z "$choice" ]; then
      choice=$default_choice
    fi

    case "$choice" in
      1)
        kube_proxy_mode="ipvs"
        valid=true
        ;;
      2)
        kube_proxy_mode="iptables"
        valid=true
        ;;
      *)
        warning_message "Invalid choice. Please select a valid number."
        ;;
    esac
  done
  export kube_proxy_mode
  echo -e "${success_msg}kube_proxy_mode set to: $kube_proxy_mode${reset}"
}

prompt_kube_proxy_mode