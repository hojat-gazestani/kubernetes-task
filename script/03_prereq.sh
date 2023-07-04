#!/bin/bash

# Define ANSI escape sequences for setting background and font colors
GREEN_BACKGROUND='\033[42m'
BLACK_FONT='\033[30m'
DEFAULT_COLOR='\033[0m'


PREREQ() {
sudo sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab
sudo swapoff -a

sudo systemctl stop apparmor
sudo systemctl disable apparmor

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
}
