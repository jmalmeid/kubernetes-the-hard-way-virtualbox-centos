#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-etcd.sh /home/vagrant/configure-etcd.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-etcd.sh && ./configure-etcd.sh"
done
