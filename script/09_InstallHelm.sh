#!/bin/bash

error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

installHelm() {
  echo -e "${warning_msg}Installing Helm...${reset}"

  # Download Helm package
  wget https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz || {
    echo -e "${error_msg}Error: Failed to download Helm package.${reset}" >&2
    exit 1
  }

  # Extract Helm package
  sudo tar xvf helm-v3.12.1-linux-amd64.tar.gz -C /usr/local/bin --strip-components=1 linux-amd64/helm || {
    echo -e "${error_msg}Error: Failed to extract Helm package.${reset}" >&2
    exit 1
  }

#  # Move Helm binary to /usr/local/bin
#  sudo mv linux-amd64/helm /usr/local/bin || {
#    echo -e "${error_msg}Error: Failed to move Helm binary to /usr/local/bin.${reset}" >&2
#    exit 1
#  }

  echo -e "${success_msg}Helm installed successfully! Checking Helm version...${reset}"
  helm version
}

helmVersion() {
  echo -e "${warning_msg}Checking Helm version...${reset}"
  helm version
}

