#!/bin/bash

instance=controller-0

vagrant upload scripts/k8s-the-hard-way/rbac-for-kubelet-auth.sh /home/vagrant/rbac-for-kubelet-auth.sh ${instance}
vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x rbac-for-kubelet-auth.sh && ./rbac-for-kubelet-auth.sh"
