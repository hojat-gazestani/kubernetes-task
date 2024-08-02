#!/bin/bash

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

setupKubespray() {
  echo -e "${warning_msg}Setting up Kubespray 1.3.0 ...${reset}"

  #git clone https://github.com/kubernetes-sigs/kubespray.git || {
  git clone https://github.com/kubernetes-incubator/kubespray.git || {
    echo -e "${error_msg}Error: Failed to clone Kubespray repository.${reset}" >&2
    exit 1
  }
  cd kubespray
#  git checkout release-2.16 || {
#    echo "Error: Failed to switch to release-2.16 branch." >&2
#    exit 1
#  }
  sudo apt-get update -y
  sudo apt-get update --fix-missing
  sudo apt install python3-venv python3-pip python3 -y
  # Create Python virtual environment
  python3 -m venv venv || {
    echo -e "${error_msg}Error: Failed to Create Python virtual environment.${reset}" >&2
    exit 1
  }
  source venv/bin/activate

  # Install Python dependencies
  pip install --upgrade pip
  pip install -r requirements.txt

  # Copy inventory folder
  cp -rfp inventory/local inventory/$CLUSTER_FOLDER
}
