#!/bin/bash

wget --timestamping \
  https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.21.0/crictl-v1.21.0-linux-amd64.tar.gz \
  https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 \
  https://github.com/containernetworking/plugins/releases/download/v0.9.1/cni-plugins-linux-amd64-v0.9.1.tgz \
  https://github.com/containerd/containerd/releases/download/v1.4.4/containerd-1.4.4-linux-amd64.tar.gz \
  https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubelet

for instance in worker-0 worker-1 worker-2; do
  vagrant upload crictl-v1.21.0-linux-amd64.tar.gz /home/vagrant/crictl-v1.21.0-linux-amd64.tar.gz ${instance}
  vagrant upload runc.amd64 /home/vagrant/runc.amd64 ${instance}
  vagrant upload cni-plugins-linux-amd64-v0.9.1.tgz /home/vagrant/cni-plugins-linux-amd64-v0.9.1.tgz ${instance}
  vagrant upload containerd-1.4.4-linux-amd64.tar.gz /home/vagrant/containerd-1.4.4-linux-amd64.tar.gz ${instance}
  vagrant upload kubectl /home/vagrant/kubectl ${instance}
  vagrant upload kube-proxy /home/vagrant/kube-proxy ${instance}
  vagrant upload kubelet /home/vagrant/kubelet ${instance}
  vagrant upload scripts/k8s-the-hard-way/install-workers.sh /home/vagrant/install-workers.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x install-workers.sh && ./install-workers.sh"
done

rm -f crictl-v1.21.0-linux-amd64.tar.gz runc.amd64 cni-plugins-linux-amd64-v0.9.1.tgz containerd-1.4.4-linux-amd64.tar.gz kubectl kube-proxy kubelet
