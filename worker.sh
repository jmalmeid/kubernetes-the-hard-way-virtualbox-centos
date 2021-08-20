#!/bin/bash

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

