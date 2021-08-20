#!/bin/bash

wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/linux/amd64/kubectl"

for instance in controller-0 controller-1 controller-2; do
  vagrant upload kube-apiserver /home/vagrant/kube-apiserver ${instance}
  vagrant upload kube-controller-manager /home/vagrant/kube-controller-manager ${instance}
  vagrant upload kube-scheduler /home/vagrant/kube-scheduler ${instance}
  vagrant upload kubectl /home/vagrant/kubectl ${instance}
  vagrant ssh ${instance} -c "sudo mkdir -p /etc/kubernetes/config && cd /home/vagrant && chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl && sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/"
done

rm -f kube-apiserver kube-controller-manager kube-scheduler kubectl
