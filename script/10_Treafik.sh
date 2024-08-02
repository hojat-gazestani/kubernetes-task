#!/bin/bash

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

installTraefik() {
  # Create Traefik namespace and install Traefik
  echo -e "${warning_msg}Creating Traefik namespace and installing Traefik...${reset}"
  kubectl create namespace traefik || {
    echo -e "${error_msg}Error: Failed to create Traefik namespace .${reset}" >&2
    exit 1
  }
  helm install traefik ./traefik  -n traefik --create-namespace || {
    echo -e "${error_msg}Error: Failed to install Traefik .${reset}" >&2
    exit 1
  }

  # Retrieve Traefik IP for accessing the dashboard
  TR_IP=$(kubectl get svc -n traefik | awk '{print $4}' | tail -n 1)
  echo -e "${success_msg}You have access to the Traefik dashboard at http://$TR_IP:9000${reset}"
}

