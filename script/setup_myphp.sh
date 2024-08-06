#!/bin/bash

# Define ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
reset="\033[0m"

setup_myphp() {
  echo -e "${success_msg}Installing My phpMyAdmin...${reset}"

  # Install phpMyAdmin using Helm
  if helm install myphp ./myphp ; then
    echo -e "${success_msg}My phpMyAdmin installation completed successfully.${reset}"
    TR_IP=$(kubectl get svc -n traefik | awk '{print $4}' | tail -n 1)
    echo -e "${success_msg}${BLACK_FONT}Configure $TR_IP  My phpmyadmin.local in you hosts file to have access to PhpMyAdmin.${reset}"
  else
    echo -e "${error_msg}Failed to install My phpMyAdmin.${reset}"
    exit 1
  fi
}