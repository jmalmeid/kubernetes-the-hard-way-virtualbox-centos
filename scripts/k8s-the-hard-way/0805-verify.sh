#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  vagrant ssh ${instance} -c "cd /home/vagrant && kubectl get componentstatuses --kubeconfig admin.kubeconfig"
done
