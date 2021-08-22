#!/bin/bash

for instance in controller-0 controller-1 controller-2 worker-0 worker-1 worker-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-routing.sh /home/vagrant/configure-routing.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-routing.sh && ./configure-routing.sh"
done

