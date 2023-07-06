#!/bin/bash

source ./script/01_check_usr.sh
source ./script/02_check_os.sh
source ./script/03_prereq.sh
source ./script/04_0_kubespray.sh
source ./script/05_InstallLPP.sh
source ./script/07_setMetallbIPRange.sh
source ./script/08_MetaLLB.sh
source ./script/09_InstallHelm.sh
source ./script/10_Treafik.sh
source ./script/11_Config_repo.sh
source ./script/12_installMySQL.sh
source ./script/13_InstallingPHPmyAdmin.sh
source ./script/14_InstallWordPress.sh
source ./script/15_myphp.sh

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
# installPhpMyAdmin

## Installing Wordpress
# installWordPress

## Running my PhpMyAdmin
# myphp
