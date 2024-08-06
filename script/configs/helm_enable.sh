#!/bin/bash

source ./prompts/messages.sh

configure_helm() {
  if [ "$helm_enabled" = true ]; then
    sed -i 's/helm_enabled: false/helm_enabled: true/' "$addos_config_file" || error_message "Failed to enable Helm."
  fi
}
