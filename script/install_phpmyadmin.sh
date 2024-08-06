#!/bin/bash

# Define ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

install_phpmyadmin() {
  echo -e "${warning_msg}Installing phpMyAdmin...${reset}"

  # Install phpMyAdmin using Helm
  if helm install phpmyadmin ./phpmyadmin ; then
    echo -e "${success_msg}phpMyAdmin installation completed successfully.${reset}"
    TR_IP=$(kubectl get svc -n traefik | awk '{print $4}' | tail -n 1)
    echo -e "${success_msg}Configure $TR_IP  hojat.loca.com/dbadmin in you hosts file to have access to PhpMyAdmin.${reset}"
  else
    echo -e "${error_msg}Failed to install phpMyAdmin.${reset}"
    exit 1
  fi
}

