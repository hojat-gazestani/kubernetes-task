#!/bin/bash

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

install_mysql() {
  # Install MySQL
  echo -e "${warning_msg}Installing MySQL...${reset}"
  helm install mysql ./mysql || {
    echo -e "${error_msg}Error: Failed to install MySQL .${reset}" >&2
    exit 1
  }

  echo -e "${success_msg}MySQL installation completed.${reset}"
}

