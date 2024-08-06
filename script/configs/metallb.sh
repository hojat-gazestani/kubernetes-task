#!/bin/bash

source ./prompts/messages.sh

update_metallb_configuration() {
  if [ "$metallb_enabled" = true ]; then
    sed -i 's/metallb_enabled: false/metallb_enabled: true/' "$addos_config_file" || error_message "Failed to enable MetalLB."
  fi

  # Add or update containerd registry if required
  if ! grep -q "containerd_registries" "$containerd_file"; then
    cat >> "$containerd_file" << EOF
containerd_registries:
  "docker.io":
    - "https://mirror.gcr.io"
    - "https://registry-1.docker.io"
EOF
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
