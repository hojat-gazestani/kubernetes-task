#!/bin/bash

source ./script/prompts/messages.sh

configure_ingress_nginx() {
  if [ "$ingress_nginx_enabled" = true ]; then
    sed -i 's/ingress_nginx_enabled: false/ingress_nginx_enabled: true/' "$addos_config_file" || error_message "Failed to enable Ingress NGINX."
  fi
}