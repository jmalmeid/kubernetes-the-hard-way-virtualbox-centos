#!/bin/bash

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo rm -f /swapfile1

yum -y install epel-release

yum -y remove firewalld
yum install -y iptables-services
systemctl enable iptables
systemctl start iptables
 
#iptables
iptables -I INPUT -p udp -m state --state NEW -m udp --dport 53 -j ACCEPT
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 53 -j ACCEPT
iptables -I INPUT -p udp -m state --state NEW -m udp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -p udp -m multiport --dports 9000-11000 -j ACCEPT
iptables -I INPUT -m state --state NEW -p tcp -m multiport --dports 9000-11000 -j ACCEPT
iptables -I INPUT -p igmp -j ACCEPT
iptables -I INPUT -m addrtype --dst-type MULTICAST -j ACCEPT
iptables-save > /etc/sysconfig/iptables

