#!/bin/bash

source ./script/promtps/messages.sh
source ./script/check_user.sh
source ./script/check_os.sh
source ./script/prerequisites.sh
source ./script/kubespray_init.sh
source ./script/install_lpp.sh
source ./script/set_metallb_ip_range.sh
source ./script/install_metallb.sh
source ./script/install_helm.sh
source ./script/install_traefik.sh
source ./script/config_repo.sh
source ./script/install_mysql.sh
source ./script/install_phpmyadmin.sh
source ./script/install_wordpress.sh
source ./script/setup_myphp.sh

warning_message "Cheking if run as root"
# check_user

warning_message "Checking if OS release is Ubuntu 20.04 and 22.04"
# check_os

warning_message "configuring kubernetes cluster pre requirements"
# configure_prerequisites


warning_message "Bootstrapping kubernetes cluster with kubespray"
 initialize_kubespray

warning_message "Installing Local Path Provisioner"
# install_local_path_provisioner

warning_message "Setting MetaLLB IP range"
# set_metallb_ip_range
warning_message "Installation of Local Path Provisioner"
# install_metallb


warning_message "Installing  Helm"
# install_helm
warning_message "Checking Helm version"
# check_helm_version

warning_message "Installing Traefik"
# install_traefik


warning_message "Adding bitnami repository"
# configure_helm_repository

warning_message "Installing MySQL"
# install_mysql

warning_message "Calling the function to install phpMyAdmin"
# install_phpmyadmin

warning_message "Installing Wordpress"
# install_wordpress

warning_message "Running my PhpMyAdmin"
# setup_myphp
