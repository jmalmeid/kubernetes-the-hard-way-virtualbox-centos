# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 1
    vb.memory = 1024
    vb.name = "vm"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  # must be at the top
  config.vm.define "lb-0" do |c|
      c.vm.provider :virtualbox do |vb|
        vb.name = "lb-0"
      end 
      c.vm.hostname = "lb-0"
      c.vm.network "public_network", ip: "10.240.0.40"
      c.vm.network "private_network", ip: "10.140.0.40"

      c.vm.provision :shell, :path => "scripts/bootstrap/vagrant-setup-haproxy.sh"

      c.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
  end

  (0..2).each do |n|
    config.vm.define "controller-#{n}" do |c|
        c.vm.provider :virtualbox do |vb|
          vb.name = "controller-#{n}"
        end 
        c.vm.hostname = "controller-#{n}"
        c.vm.network "public_network", ip: "10.240.0.1#{n}"
        c.vm.network "private_network", ip: "10.140.0.1#{n}"

        c.vm.provision :shell, :path => "scripts/bootstrap/vagrant-setup-controller.sh"
    end
  end

  (0..2).each do |n|
    config.vm.define "worker-#{n}" do |c|
        c.vm.provider :virtualbox do |vb|
          vb.name = "worker-#{n}"
        end 
        c.vm.hostname = "worker-#{n}"
        c.vm.network "public_network", ip: "10.240.0.2#{n}"
        c.vm.network "private_network", ip: "10.140.0.2#{n}"

        c.vm.provision :shell, :path => "scripts/bootstrap/vagrant-setup-routes.sh"
        c.vm.provision :shell, :path => "scripts/bootstrap/vagrant-setup-worker.sh"
      c.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  end

end
