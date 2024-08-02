#!/bin/bash

source ./script/05_kubespray_setup.sh
source ./script/06_kubespray_configure.sh
source ./script/07_kubespray_run.sh

error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

KUBESPARY() {
  NODE=$(ip -o -4 addr show up scope global | awk '{print $4}' | cut -d "/" -f 1 | while read -r IP; do if ip route get 172.16.6.1 | grep -q "$IP"; then echo "$IP"; break; fi; done)
  
  echo -n -e "${warning_msg}Is $NODE your Kubernetes master node IP address (Y|n)?${reset}"
  read -n 15 ANS
  if [[ $ANS =~ ^[Nn]$ ]] ; then
    echo -n  -e "${error_msg}Please enter the correct address:${reset}"
    read -n 15 NODE
  fi
    
  echo -e "${success_msg}Setup a Kubernetes cluster on $NODE using Kubespray...${reset}"

  declare -r CLUSTER_FOLDER='my-cluster'
  setupKubespray
  configureKubespray
  runKubespray
}

