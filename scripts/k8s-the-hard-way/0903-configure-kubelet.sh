#!/bin/bash

for instance in worker-0 worker-1 worker-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-kubelet.sh /home/vagrant/configure-kubelet.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-kubelet.sh && ./configure-kubelet.sh"
done
