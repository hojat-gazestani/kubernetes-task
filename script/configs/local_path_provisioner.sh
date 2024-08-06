#!/bin/bash

source ./prompts/messages.sh


configure_local_path_provisioner() {
  if [ "$local_path_provisioner_enabled" = true ]; then
    sed -i 's/local_path_provisioner_enabled: false/local_path_provisioner_enabled: true/' "$addos_config_file" || error_message "Failed to enable Local Path Provisioner."
  fi
}
