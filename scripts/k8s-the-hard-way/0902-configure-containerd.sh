#!/bin/bash

for instance in worker-0 worker-1 worker-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-containerd.sh /home/vagrant/configure-containerd.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-containerd.sh && ./configure-containerd.sh"
done
