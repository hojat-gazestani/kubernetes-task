#!/bin/bash
setUpMetaLLB() {
kubectl apply -f /home/$USER/kubernetes-task/metallb/metallb-native.yaml
kubectl apply -f /home/$USER/kubernetes-task/metallb/ipPool.yaml
kubectl apply -f /home/$USER/kubernetes-task/metallb/l2adver.yaml
}