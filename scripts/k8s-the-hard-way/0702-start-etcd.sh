#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  vagrant ssh ${instance} -c "sudo systemctl daemon-reload && sudo systemctl enable etcd && sudo systemctl start etcd && sudo systemctl status etcd -l"
done
