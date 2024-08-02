#!/bin/bash
error_msg="\033[41;37m"
success_msg="\033[32;40m"
warning_msg="\033[33;40m"
reset="\033[0m"


setMetallbIPRange() {
  MYIP=$(ip -o -4 addr show up scope global | awk '{print $4}' | cut -d "/" -f 1 | while read -r IP; do if ip route get 172.16.6.1 | grep -q "$IP"; then echo "$IP"; break; fi; done)
  #RANGE=$(echo $NODE | awk -F "." '{print $1"."$2"."$3"."}')
  META_IP="$MYIP-$MYIP"

  echo -e "${warning_msg}Your management IP address is${reset} $NODE."
  echo -e "${warning_msg}Your MetaLLB IP range would be${reset} $META_IP."

  echo -n -e "${warning_msg}If it is incorrect, please press Y to continue or N and enter the correct MetaLLB IP range:${reset} " 
  read -n 15 ANSWER

  if [[ -z $ANSWER || $ANSWER =~ ^[Yy]$ ]]; then
    echo -e "${warning_msg}Final MetaLLB IP range:${reset} $META_IP"
  else
    echo -n -e "${warning_msg}Please input the correct MetaLLB IP range e.g: (192.168.1.240-192.168.1.250) : ${reset}" 
    read -n 15 NEW_META_IP
    META_IP="$NEW_META_IP"
    echo -e "${warning_msg}Final MetaLLB IP range:${reset} $META_IP"
  fi

  echo -e "${warning_msg}Setting up MetaLLB IP range on file ipPool.yaml${reset}"
  sed -i "s/RANGE/$META_IP/g" ./metallb/ipPool.yaml || {
      echo "${error_msg}Error: Failed to Set up MetaLLB IP range on file ipPool.yaml.${reset}" >&2
      exit 1
  }
}
