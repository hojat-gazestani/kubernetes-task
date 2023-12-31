#!/bin/bash

# Define ANSI escape sequences for setting background and font colors
GREEN_BACKGROUND='\033[42m'
BLACK_FONT='\033[30m'
DEFAULT_COLOR='\033[0m'

setupKubespray() {
  echo "${GREEN_BACKGROUND}${BLACK_FONT}Setting up Kubespray 1.3.0 ...${DEFAULT_COLOR}"

  #git clone https://github.com/kubernetes-sigs/kubespray.git || {
  git clone https://github.com/kubernetes-incubator/kubespray.git || {
    echo "${GREEN_BACKGROUND}${BLACK_FONT}Error: Failed to clone Kubespray repository.${DEFAULT_COLOR}" >&2
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
    echo "${GREEN_BACKGROUND}${BLACK_FONT}Error: Failed to Create Python virtual environment.${DEFAULT_COLOR}" >&2
    exit 1
  }
  source venv/bin/activate

  # Install Python dependencies
  pip install --upgrade pip
  pip install -r requirements.txt

  # Copy inventory folder
  cp -rfp inventory/local inventory/$CLUSTER_FOLDER
}
