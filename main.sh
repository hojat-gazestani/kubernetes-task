#!/bin/bash

source ./script/01_check_user.sh
source ./script/02_check_os.sh
source ./script/03_prerequisites.sh
source ./script/04_kubespray_init.sh
source ./script/08_install_lpp.sh
source ./script/09_set_metallb_ip_range.sh
source ./script/10_install_metallb.sh
source ./script/11_install_helm.sh
source ./script/12_install_traefik.sh
source ./script/13_config_repo.sh
source ./script/14_install_mysql.sh
source ./script/15_install_phpmyadmin.sh
source ./script/16_install_wordpress.sh
source ./script/17_setup_myphp.sh

## Run me as root
 check_user
## Check if OS release is Ubuntu 20.04
 check_os
## configuring kubernetes cluster pre requirements
 configure_prerequisites
##-----------------------------------------------------
## Bootstrapping kubernetes cluster with kubespray
 initialize_kubespray

## Installing Local Path Provisioner
 install_local_path_provisioner

## Setting MetaLLB IP range
 set_metallb_ip_range
## Installation of Local Path Provisioner
 install_metallb


## Installing  Helm
 install_helm
## Check Helm version
 check_helm_version

## Installing Traefik
 install_traefik
##-----------------------------------------------------
## Add bitnami repository
 configure_helm_repository

## Install MySQL
 install_mysql

## Call the function to install phpMyAdmin
 install_phpmyadmin

## Installing Wordpress
 install_wordpress

## Running my PhpMyAdmin
# setup_myphp
