#!/bin/bash

for instance in worker-0 worker-1 worker-2; do
  vagrant ssh ${instance} -c "sudo systemctl daemon-reload && sudo systemctl enable containerd kubelet kube-proxy && sudo systemctl restart containerd kubelet kube-proxy && sudo systemctl status containerd kubelet kube-proxy -l"
done
