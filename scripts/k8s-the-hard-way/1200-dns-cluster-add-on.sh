#!/bin/bash

kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml
#kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns-1.8.yaml

watch kubectl get pods -l k8s-app=kube-dns -n kube-system
