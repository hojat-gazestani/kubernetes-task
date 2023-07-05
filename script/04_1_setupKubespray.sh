#!/bin/bash

setupKubespray() {
  echo "Setting up Kubespray 1.3.0 ..."
  # I have tested Kubespray versions 1.3.0 and 2/16. By default, it will bootstrap with version 1.3.0.
  git clone https://github.com/kubernetes-sigs/kubespray.git || {
    echo "Error: Failed to clone Kubespray repository." >&2
    exit 1
  }
  cd kubespray
  # git checkout release-2.16 || {
  #   echo "Error: Failed to switch to release-2.16 branch." >&2
  #   exit 1
  # }
  git checkout 1.3.0 | {
     echo "Error: Failed to switch to release-1.3.0 branch." >&2
     exit 1
  }
  sudo apt-get update -y
  sudo apt-get update --fix-missing
  sudo apt install python3-venv python3-pip -y # python3.8-venv
  # Create Python virtual environment
  python3 -m venv venv || {
    echo "Error: Failed to Create Python virtual environment." >&2
    exit 1
  }
  source venv/bin/activate

  # Install Python dependencies
  pip install --upgrade pip
  pip install -r requirements.txt

  # Copy inventory folder
  cp -rfp inventory/local inventory/$CLUSTER_FOLDER
}
