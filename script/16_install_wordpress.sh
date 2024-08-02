#!/bin/bash

# Define ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"


installWordPress() {
  echo -e "${warning_msg}Installing WordPress...${reset}"

  # Install WordPress using Helm
  if helm install wordpress ./wordpress ; then
    echo -e "${success_msg}WordPress installation completed successfully.${reset}"
    TR_IP=$(kubectl get svc -n traefik | awk '{print $4}' | tail -n 1)
    echo -e "${success_msg}Configure $TR_IP  hojat.local.com/wordpresss in you hosts file to have access to PhpMyAdmin.${reset}"
  else
    echo -e "${error_msg}Failed to install WordPress.${reset}"
    exit 1
  fi
}