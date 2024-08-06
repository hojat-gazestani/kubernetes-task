#!/bin/bash

source ./prompts/messages.sh

configure_network_plugin() {
    if [ $NetPlugin != "calico" ]; then
          sed -i "s/kube_network_plugin: .*/kube_network_plugin: $NetPlugin/" "$config_file" || error_message "Failed to configure network plugin."
    fi
}
