#!/bin/bash

for instance in worker-0 worker-1 worker-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-kube-proxy.sh /home/vagrant/configure-kube-proxy.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-kube-proxy.sh && ./configure-kube-proxy.sh"
done
