#!/bin/bash

for instance in worker-0 worker-1 worker-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-cni.sh /home/vagrant/configure-cni.sh ${instance}
  vagrant ssh ${instance} -c "sudo yum -y install socat conntrack ipset && cd /home/vagrant && chmod +x configure-cni.sh && ./configure-cni.sh"
done
