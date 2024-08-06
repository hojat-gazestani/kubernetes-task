#!/bin/bash

source ./prompts/messages.sh

configure_metallb() {
  if [ "$metallb_enabled" = true ]; then
    sed -i 's/metallb_enabled: false/metallb_enabled: true/' "$addos_config_file" || error_message "Failed to enable MetalLB."


  fi

#   cat >> inventory/$CLUSTER_FOLDER/group_vars/k8s_cluster/addons.yml << EOF
# metallb_ip_range:
#   - "10.5.0.50-10.5.0.50"
# metallb_controller_tolerations:
#   - key: "node-role.kubernetes.io/master"
#     operator: "Equal"
#     value: ""
#     effect: "NoSchedule"
#   - key: "node-role.kubernetes.io/control-plane"
#     operator: "Equal"
#     value: ""
#     effect: "NoSchedule"
# EOF
}
