#!/bin/bash

source ./script/prompts/messages.sh


configure_argocd() {
  if [ "$argocd_enabled" = true ]; then
    sed -i 's/argocd_enabled: false/argocd_enabled: true/' "$addos_config_file" || error_message "Failed to enable ArgoCD."

  fi
}