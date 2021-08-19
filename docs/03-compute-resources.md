# Provisioning Compute Resources

Kubernetes requires a set of machines to host the Kubernetes control plane and the worker nodes where containers are ultimately run. In this lab you will provision the compute resources required for running a secure and highly available Kubernetes cluster.


## Networking

The Kubernetes [networking model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#kubernetes-model) assumes a flat network in which containers and nodes can communicate with each other. In cases where this is not desired [network policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) can limit how groups of containers are allowed to communicate with each other and external network endpoints.

Each machine uses two network interface, one for access the Internet with type "NAT", the other for Kubernetes internal communication with type "Host-only Adapter".


## Compute Instances

The compute instances in this lab will be provisioned using [Ubuntu Server](https://www.ubuntu.com/server) 16.04, which has good support for the [cri-containerd container runtime](https://github.com/kubernetes-incubator/cri-containerd). Each compute instance will be provisioned with a fixed private IP address to simplify the Kubernetes bootstrapping process.


### 用 Vagrant 启动虚拟机

```
vagrant up
```

> output

```
Bringing machine 'controller-0' up with 'virtualbox' provider...
Bringing machine 'controller-1' up with 'virtualbox' provider...
Bringing machine 'controller-2' up with 'virtualbox' provider...
Bringing machine 'worker-0' up with 'virtualbox' provider...
Bringing machine 'worker-1' up with 'virtualbox' provider...
Bringing machine 'worker-2' up with 'virtualbox' provider...
...
...

```

### Summary
List the compute instances:

```
vagrant status
```

> output
```
controller-0              running (virtualbox)
controller-1              running (virtualbox)
controller-2              running (virtualbox)
worker-0                  running (virtualbox)
worker-1                  running (virtualbox)
worker-2                  running (virtualbox)
```

## Add VIP
```
vagrant ssh controller-0
sudo pcs cluster auth controller-0 controller-1 controller-2
```

> output

```
Username: hacluster
Password: 
controller-2: Authorized
controller-1: Authorized
controller-0: Authorized
```

```
sudo pcs cluster setup --name kubernetes-ward-way controller-0 controller-1 controller-2
sudo pcs cluster start --all
sudo pcs status cluster
sudo pcs status nodes
sudo corosync-cmapctl | grep members
sudo pcs status corosync
sudo crm_verify -L -V
sudo pcs property set stonith-enabled=false
sudo pcs property set no-quorum-policy=ignore
sudo pcs property
sudo pcs resource create virtual_ip ocf:heartbeat:IPaddr2 ip=192.168.100.100 cidr_netmask=32 op monitor interval=30s
sudo pcs status|grep virtual_ip
```

> output

```
```

```
```

> output

```
```

```


## Kubernetes Master VIP
Vagrant `heartbeat.sh`， heartbeat 3 个 controller 节点上建立 VIP: 192.168.100.100。此 IP 用于外部访问 Kubernetes。

### 验证
```
ping -c 1 192.168.100.100
```

> output

```
PING 192.168.100.100 (192.168.100.100): 56 data bytes
64 bytes from 192.168.100.100: icmp_seq=0 ttl=64 time=0.438 ms

--- 192.168.100.100 ping statistics ---
1 packets transmitted, 1 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 0.438/0.438/0.438/0.000 ms
```

Next: [Provisioning a CA and Generating TLS Certificates](04-certificate-authority.md)
