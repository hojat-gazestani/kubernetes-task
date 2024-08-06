#!/bin/bash

source ./script/prompts/messages.sh

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

prompt_network_plugin() {
  local valid=false
  local choice
  local default_choice=2  # Default is calico

  while [ "$valid" = false ]; do
    warning_message "Choose network plugin by number:"
    echo "1) cilium"
    echo "2) calico"
    echo "3) kube-ovn"
    echo "4) weave"
    echo "5) flannel"
    echo "6) cni (generic CNI plugin)"
    echo "7) cloud (let cloud provider set up routing)"
    echo -n -e "${warning_msg}Please enter the number of the network plugin (default: $default_choice): ${reset}"
    read -r -n 1 choice
    echo # Move to the next line

    # If no choice is entered, use the default
    if [ -z "$choice" ]; then
      choice=$default_choice
    fi

    case "$choice" in
      1)
        NetPlugin="cilium"
        valid=true
        ;;
      2)
        NetPlugin="calico"
        valid=true
        ;;
      3)
        NetPlugin="kube-ovn"
        valid=true
        ;;
      4)
        NetPlugin="weave"
        valid=true
        ;;
      5)
        NetPlugin="flannel"
        valid=true
        ;;
      6)
        NetPlugin="cni"
        valid=true
        ;;
      7)
        NetPlugin="cloud"
        valid=true
        ;;
      *)
        warning_message "Invalid choice. Please select a valid number."
        ;;
    esac
  done
  export NetPlugin
  echo -e "${success_msg}Network plugin set to: $NetPlugin${reset}"
}

# Example usage
#Zprompt_network_plugin
