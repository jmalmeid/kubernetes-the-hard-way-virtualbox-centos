#!/bin/bash

cd /home/vagrant

sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes

{
  mkdir containerd
  tar -xvf crictl-v1.21.0-linux-amd64.tar.gz
  tar -xvf containerd-1.4.4-linux-amd64.tar.gz -C containerd
  sudo tar -xvf cni-plugins-linux-amd64-v0.9.1.tgz -C /opt/cni/bin/
  sudo chown root: /opt/cni/bin/*
  mv runc.amd64 runc
  chmod +x crictl kubectl kube-proxy kubelet runc
  sudo chown root: crictl kubectl kube-proxy kubelet runc containerd/bin/*
  sudo cp crictl kubectl kube-proxy kubelet runc /usr/local/bin/
  sudo cp containerd/bin/* /bin/
}

