#!/bin/bash

setMetallbIPRange() {
  MYIP=$(ip -o -4 addr show up scope global | awk '{print $4}' | cut -d "/" -f 1 | while read -r IP; do if ip route get 172.16.6.1 | grep -q "$IP"; then echo "$IP"; break; fi; done)
  #RANGE=$(echo $NODE | awk -F "." '{print $1"."$2"."$3"."}')
  META_IP="$MYIP-$MYIP"

  echo "Your management IP address is $NODE."
  echo "Your MetaLLB IP range would be $META_IP."

  read -p "If it is incorrect, please press Y to continue or enter the correct MetaLLB IP range: " ANSWER

  if [[ -z $ANSWER || $ANSWER =~ ^[Yy]$ ]]; then
    echo "Final MetaLLB IP range: $META_IP"
  else
    read -p "Please input the correct MetaLLB IP range: " NEW_META_IP
    META_IP="$NEW_META_IP"
    echo "Final MetaLLB IP range: $META_IP"
  fi
}

echo "Setting up MetaLLB IP range on file ipPool.yaml"
sed "s/RANGE/$META_IP/g" /home/$USER/kubernetes-task/metallb/ipPool.yaml || {
    echo "${GREEN_BACKGROUND}${BLACK_FONT}Error: Failed to Set up MetaLLB IP range on file ipPool.yaml.${DEFAULT_COLOR}" >&2
    exit 1
}