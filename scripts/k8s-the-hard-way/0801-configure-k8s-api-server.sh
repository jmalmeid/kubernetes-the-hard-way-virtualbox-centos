 #!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  vagrant upload scripts/k8s-the-hard-way/configure-k8s-api-server.sh /home/vagrant/configure-k8s-api-server.sh ${instance}
  vagrant ssh ${instance} -c "cd /home/vagrant && chmod +x configure-k8s-api-server.sh && ./configure-k8s-api-server.sh"
done
