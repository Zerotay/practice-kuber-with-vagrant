#!/bin/bash

kubeadm reset -f

kubeadm init --pod-network-cidr=10.96.0.0/16 --apiserver-advertise-address=192.168.32.10 > adm.log
tail -2 adm.log > worker-init.sh && rm adm.log

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

curl https://docs.projectcalico.org/archive/v3.25/manifests/calico.yaml -O --insecure
kubectl apply -f calico.yaml
kubectl get pods --all-namespaces
