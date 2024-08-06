#!/bin/bash

source ./script/prompts/messages.sh

configure_kube_proxy_mode() {
  # Update kube_proxy_mode
  if [ "$kube_proxy_mode" = "iptables" ]; then
    sed -i 's/kube_proxy_mode: ipvs/kube_proxy_mode: iptables/' "$config_file" || error_message "Failed to configure kube-proxy mode."
  fi
}
