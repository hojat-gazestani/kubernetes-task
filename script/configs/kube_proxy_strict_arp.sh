#!/bin/bash

source ./prompts/messages.sh

configure_kube_proxy_strict_arp() {
  if [ "$kube_proxy_strict_arp" = false ]; then
    sed -i 's/kube_proxy_strict_arp: true/kube_proxy_strict_arp: false/' "$config_file" || error_message "Failed to configure kube-proxy strict ARP."
  fi
}
