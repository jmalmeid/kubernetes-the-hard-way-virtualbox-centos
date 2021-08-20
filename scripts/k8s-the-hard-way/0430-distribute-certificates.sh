#!/bin/bash

# This script assumes you have the vagrant-upload plugin installed

for instance in worker-0 worker-1 worker-2; do
  vagrant upload ca.pem /home/vagrant/ca.pem ${instance}
  vagrant upload ${instance}-key.pem /home/vagrant/${instance}-key.pem ${instance}
  vagrant upload ${instance}.pem /home/vagrant/${instance}.pem ${instance}
done

for instance in controller-0 controller-1 controller-2; do
  vagrant upload ca.pem /home/vagrant/ca.pem ${instance}
  vagrant upload ca-key.pem /home/vagrant/ca-key.pem ${instance}
  vagrant upload kubernetes-key.pem /home/vagrant/kubernetes-key.pem ${instance}
  vagrant upload kubernetes.pem /home/vagrant/kubernetes.pem ${instance}
  vagrant upload service-account-key.pem /home/vagrant/service-account-key.pem ${instance}
  vagrant upload service-account.pem /home/vagrant/service-account.pem ${instance}
done
