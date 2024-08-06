#!/bin/bash

source ./script/prompts/messages.sh
source ./script/prompts/network_plugin.sh

kubespray_configure() {
  warning_message "Configuring Kubespray..."

  warning_message "Generate inventory"
  declare -a IPS=($NODE)
  # TODO Don't use node1 name and give it from input
  CONFIG_FILE=inventory/$CLUSTER_FOLDER/hosts.yaml python3 contrib/inventory_builder/inventory.py "${IPS[@]}" || error_message "Failed to generate inventory."

  warning_message "Configure kubespray settings"
  sed -i 's/kube_proxy_strict_arp: false/kube_proxy_strict_arp: true/' inventory/$CLUSTER_FOLDER/group_vars/k8s_cluster/k8s-cluster.yml || error_message "Failed to configure kube-proxy."

  sed -i 's/metallb_enabled: false/metallb_enabled: true/' inventory/$CLUSTER_FOLDER/group_vars/k8s_cluster/addons.yml || error_message "Failed to enable MetalLB."

  cat >> inventory/$CLUSTER_FOLDER/group_vars/k8s_cluster/addons.yml << EOF
metallb_ip_range:
  - "10.5.0.50-10.5.0.50"
metallb_controller_tolerations:
  - key: "node-role.kubernetes.io/master"
    operator: "Equal"
    value: ""
    effect: "NoSchedule"
  - key: "node-role.kubernetes.io/control-plane"
    operator: "Equal"
    value: ""
    effect: "NoSchedule"
EOF

  sed -i 's|etcd_deployment_type: docker|etcd_deployment_type: host|' inventory/$CLUSTER_FOLDER/group_vars/etcd.yml || error_message "Failed to configure etcd."

  cat >> inventory/$CLUSTER_FOLDER/group_vars/all/containerd.yml << EOF
containerd_registries:
  "docker.io":
    - "https://mirror.gcr.io"
    - "https://registry-1.docker.io"
EOF

  success_message "Kubespray configuration completed successfully."
}
