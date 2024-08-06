#!/bin/bash

source ./script/prompts/messages.sh
source ./script/prompts/network_plugin.sh
source ./script/prompts/kube_proxy_strict_arp.sh
source ./script/prompts/kube_proxy_mode.sh
source ./script/prompts/helm_enabled.sh
source ./script/prompts/cluster_folder.sh
source ./script/prompts/metallb.sh
source ./script/prompts/dashborad.sh

source ./script/configs/helm_enable.sh
source ./script/configs/kube_proxy_mode.sh
source ./script/configs/kube_proxy_strict_arp.sh
source ./script/configs/metallb.sh
source ./script/configs/network_plugin.sh
source ./script/configs/dashboard.sh


kubespray_configure() {
  warning_message "Configuring Kubespray..."

  warning_message "Generate inventory"
  declare -a IPS=($NODE)
  # TODO Don't use node1 name and give it from input
  CONFIG_FILE=inventory/$CLUSTER_FOLDER/hosts.yaml python3 contrib/inventory_builder/inventory.py "${IPS[@]}" || error_message "Failed to generate inventory."

  export k8s_config_file="inventory/$CLUSTER_FOLDER/group_vars/k8s_cluster/k8s-cluster.yml"
  export addos_config_file="inventory/$CLUSTER_FOLDER/group_vars/k8s_cluster/addons.yml"

  prompt_helm_status
  configure_helm

  prompt_kube_proxy_mode
  configure_kube_proxy_mode

  prompt_kube_proxy_strict_arp
  configure_kube_proxy_strict_arp

  prompt_network_plugin
  configure_network_plugin

  prompt_metallb
  configure_metallb

  prompt_dashboard
  configure_dashboard

  success_message "Kubespray configuration completed successfully."
}
