#!/bin/bash

source ./script/prompts/messages.sh

error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"



kubespray_run() {
  warning_message "Running Kubespray..."

  # Run Kubespray playbook
  USERNAME=$(whoami)
  ansible-playbook -i inventory/$CLUSTER_FOLDER/hosts.ini --connection=local -b -v cluster.yml || {
    error_message "Error: Failed to Run Kubespray playbook."
  }

  # Set up kubeconfig
  sudo cp -r /root/.kube $HOME || {
    error_message "Error: Failed to Set up kubeconfig."
  }
  sudo chown -R "${USER}" $HOME/.kube || {
    error_message "Error: Failed to set kubeconfig owner."
  }
  cd ..
  export KUBECONFIG=$HOME/.kube/config
  kubectl get nodes

  sudo kubectl version
}
