#!/bin/bash
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

# https://github.com/rancher/local-path-provisioner
install_local_path_provisioner() {
  echo -e "${warning_msg}Installing Local Path Provisioner...${reset}"
  kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.24/deploy/local-path-storage.yaml

  if [ $? -eq 0 ]; then
    echo  -e "${success_msg}Successfully installed Local Path Provisioner.${reset}"
  else
    echo  -e "${error_msg}Failed to install Local Path Provisioner.${reset}"
    exit 1
  fi
}