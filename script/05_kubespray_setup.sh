#!/bin/bash

source ./script/00_messages.sh

# ANSI escape sequences for setting background and font colors
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"

# Repository URL
REPO_URL="https://github.com/hojat-gazestani/kubespray.git"


# Function to prompt for cluster folder name
prompt_cluster_folder() {
  
  local default_folder="default_cluster"

  error_message "Cluster folder name not provided. I am going to exit.. " # TODO Use $CLUSTER_FOLDER instead of <local default_folder>
  echo -n -e "${warning_msg}Would you like to use the default folder name (${default_folder})? (Y/n): ${reset}"
  read -r use_default
  if [[ "$use_default" =~ ^([yY][eE][sS]|[yY])$ || -z "$use_default" ]]; then
    echo "$default_folder"
  else
    echo -n -e "${warning_msg}Please enter the cluster folder name: ${reset}"
    read -r -n 15 custom_folder
    if [ -z "$custom_folder" ]; then
      error_message "No cluster folder name provided. Exiting."
    fi
    echo "$custom_folder"
  fi
}

# Setup Kubespray function
setupKubespray() {

  # Check if the cluster folder name is provided
  if [ -z "$1" ]; then
    local cluster_folder=$(prompt_cluster_folder)
  else
    local cluster_folder="$1"
  fi



  warning_message "Setting up Kubespray ..."

  # Check for required commands
  command_exists git || error_message "Git is not installed. Please install it and try again."
  command_exists python3 || error_message "Python 3 is not installed. Please install it and try again."

  if [ ! -d kubespray ]; then
    # Clone Kubespray repository
    git clone "$REPO_URL" || error_message "Failed to clone Kubespray repository."
  fi
  cd kubespray || error_message "Failed to change directory to kubespray."

  warning_message "Updating package lists..."
  sudo apt-get update -q -y || error_message "Failed to update package lists."
  warning_message "Fixing missing packages..."
  sudo apt-get update --fix-missing -q -y || error_message "Failed to fix missing packages."

  warning_message "Installing Python dependencies"
  sudo apt install -q -y python3-venv python3-pip python3 || error_message "Failed to install Python dependencies."

  warning_message "Creating Python virtual environment"
  if [ ! -d .venv ]; then
    python3 -m venv .venv || error_message "Failed to create Python virtual environment."
  fi
  source .venv/bin/activate || error_message "Failed to activate Python virtual environment."

  # Upgrade pip and install requirements
  pip install --upgrade pip || error_message "Failed to upgrade pip."
  pip install -r requirements.txt || error_message "Failed to install Python requirements."

  # Copy inventory folder
  cp -rfp inventory/local "inventory/${cluster_folder}" || error_message "Failed to copy inventory folder."

  success_message "Kubespray setup completed successfully."
}



# Call the setup function with the determined cluster folder name
# setupKubespray "$cluster_folder"
