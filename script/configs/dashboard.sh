#!/bin/bash

source ./script/prompts/messages.sh

configure_dashboard() {
  if [ "$dashboard_enabled" = true ]; then
    sed -i 's/# dashboard_enabled: false/dashboard_enabled: true/' "$addos_config_file" || error_message "Failed to enable Kubernetes Dashboard."
  fi
}
