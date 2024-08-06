#!/bin/bash

source ./script/prompts/messages.sh

set_metallb_ip_range() {
  MYIP=$(ip -o -4 addr show up scope global | awk '{print $4}' | cut -d "/" -f 1 | while read -r IP; do if ip route get 172.16.6.1 | grep -q "$IP"; then echo "$IP"; break; fi; done)
  #RANGE=$(echo $NODE | awk -F "." '{print $1"."$2"."$3"."}')
  META_IP="$MYIP-$MYIP"

  warning_message "Your management IP address is: " "${NODE}"
  warning_message "Your MetaLLB IP range would be: " "${META_IP}"

  warning_message "Do you want to change MetaLLB IP range[Y|n]: " 
  read -r -n 15 ANSWER

  if [[ -z $ANSWER || $ANSWER =~ ^[Yy]$ ]]; then
    success_msg "Final MetaLLB IP range: " "${META_IP}"
  else
    warning_message "Please input the correct MetaLLB IP range e.g: (192.168.1.240-192.168.1.250) : " 
    read -r -n 15 NEW_META_IP
    META_IP="$NEW_META_IP"
    success_msg "Final MetaLLB IP range: " "${META_IP}"
  fi

  warning_message "Setting up MetaLLB IP range on file ipPool.yaml ..."
  sed -i "s/RANGE/$META_IP/g" ./metallb/ipPool.yaml || {
      error_msg "Error: Failed to Set up MetaLLB IP range on file ipPool.yaml." >&2
      exit 1
  }
}
