#!/bin/bash
install_metallb() {
kubectl apply -f ./metallb/metallb-native.yaml
kubectl apply -f ./metallb/ipPool.yaml
kubectl apply -f ./metallb/l2adver.yaml
}