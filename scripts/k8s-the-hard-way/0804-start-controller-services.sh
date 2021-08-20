#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  vagrant ssh ${instance} -c "sudo systemctl daemon-reload && sudo systemctl enable kube-apiserver kube-controller-manager kube-scheduler && sudo systemctl restart kube-apiserver kube-controller-manager kube-scheduler && sudo systemctl status kube-apiserver kube-controller-manager kube-scheduler" 
done
