#!/bin/bash
wget --timestamping https://github.com/coreos/etcd/releases/download/v3.4.15/etcd-v3.4.15-linux-amd64.tar.gz

for instance in controller-0 controller-1 controller-2; do
  vagrant upload etcd-v3.4.15-linux-amd64.tar.gz /home/vagrant/etcd-v3.4.15-linux-amd64.tar.gz ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && tar -xvf etcd-v3.4.15-linux-amd64.tar.gz && sudo schown -R root: etcd-* && sudo cp etcd-v3.4.15-linux-amd64/etcd* /usr/local/bin/"
done

rm -f etcd-v3.4.15-linux-amd64.tar.gz
