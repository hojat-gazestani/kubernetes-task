#!/bin/bash

source ./script/04_1_setupKubespray.sh
source ./script/04_2_configureKubespray.sh
source ./script/04_3_runKubespray.sh

KUBESPARY() {
  NODE=$(ip -o -4 addr show up scope global | awk '{print $4}' | cut -d "/" -f 1 | while read -r IP; do if ip route get 172.16.6.1 | grep -q "$IP"; then echo "$IP"; break; fi; done)
  
  read -p "Is $NODE your Kubernetes managet node IP address (Y|n)?: " ANS
  if [[ $ANS =~ ^[Nn]$ ]] ; then
    read -p "Please enter the correct address:" NODE
  fi
    
  echo "Setup a Kubernetes cluster on $NODE using Kubespray..."

  declare -r CLUSTER_FOLDER='my-cluster'
  setupKubespray
  configureKubespray
  runKubespray


}

