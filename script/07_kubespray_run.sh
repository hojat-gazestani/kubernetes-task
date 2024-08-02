#!/bin/bash

error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

runKubespray() {
  echo "Running Kubespray..."

  # Run Kubespray playbook
  USERNAME=$(whoami)
  ansible-playbook -i inventory/$CLUSTER_FOLDER/hosts.ini --connection=local -b -v cluster.yml || {
    echo -e "${error_msg}Error: Failed to Run Kubespray playbook.${reset}" >&2
    exit 1
  }

  # Set up kubeconfig
  sudo cp -r /root/.kube $HOME || {
    echo -e "${error_msg}Error: Failed to Set up kubeconfig.${reset}" >&2
    exit 1
  }
  sudo chown -R "${USER}" $HOME/.kube || {
    echo "${error_msg}Error: Failed to set kubeconfig owner.${reset}" >&2
    exit 1
  }
  cd ..
  kubectl get nodes

  sudo kubectl version
}
