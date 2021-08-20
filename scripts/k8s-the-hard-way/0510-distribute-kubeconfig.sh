#!/bin/bash

# This script assumes you have the vagrant-upload /home/vagrant/ plugin installed

for instance in worker-0 worker-1 worker-2; do
  vagrant upload ${instance}.kubeconfig /home/vagrant/${instance}.kubeconfig ${instance}
  vagrant upload kube-proxy.kubeconfig /home/vagrant/kube-proxy.kubeconfig ${instance}
done

for instance in controller-0 controller-1 controller-2; do
  vagrant upload admin.kubeconfig /home/vagrant/admin.kubeconfig ${instance}
  vagrant upload kube-controller-manager.kubeconfig /home/vagrant/kube-controller-manager.kubeconfig ${instance}
  vagrant upload kube-scheduler.kubeconfig /home/vagrant/kube-scheduler.kubeconfig ${instance}
done
