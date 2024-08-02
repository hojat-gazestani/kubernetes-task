#!/bin/bash

# Colors for comments
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

configureHelm() {
  echo -e "${warning_msg}Configuring Helm...${reset}"

  # Check if Bitnami repository is already added
  if helm repo list | grep -q "bitnami"; then
    echo -e "${success_msg}Bitnami repository already exists.${reset}"
    helm repo update
  else
    echo -e "${error_msg}Bitnami repository not found. Adding repository...${reset}"
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update
  fi
}
