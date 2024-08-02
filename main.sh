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
 CHECK_USR
## Check if OS release is Ubuntu 20.04
# CHECK_OS
## configuring kubernetes cluster pre requirements
 PREREQ
##-----------------------------------------------------
## Bootstrapping kubernetes cluster with kubespray
 KUBESPARY

## Installing Local Path Provisioner
 installLPP

## Setting MetaLLB IP range
 setMetallbIPRange
## Installation of Local Path Provisioner
 setUpMetaLLB


## Installing  Helm
 installHelm
## Check Helm version
 helmVersion

## Installing Traefik
 installTraefik
##-----------------------------------------------------
## Add bitnami repository
 configureHelm

## Install MySQL
 installMySQL

## Call the function to install phpMyAdmin
 installPhpMyAdmin

## Installing Wordpress
 installWordPress

## Running my PhpMyAdmin
# myphp
