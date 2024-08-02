#!/bin/bash

error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

CHECK_USR() {
  if [ "$EUID" -ne 0 ]; then
    echo -e "${error_msg}Please run me as root${reset}"
    exit 1
  else
    echo -e "${success_msg}You are running as root, continuing...${reset}"
  fi
}