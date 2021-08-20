#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-k8s-controller-manager.sh /home/vagrant/configure-k8s-controller-manager.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-k8s-controller-manager.sh && ./configure-k8s-controller-manager.sh"
done
