# -*- mode: ruby -*- 
# vi: set ft=ruby :

Vagrant_API_Version="2"

Vagrant.configure(Vagrant_API_Version) do |config|
  # Node01
  config.vm.define "k8s-node01" do |cfg|
    cfg.vm.box = "generic/ubuntu2004"
    cfg.vm.box_version = "3.1.16"
    cfg.vm.provider:virtualbox do |vb|
      vb.name = "K8s-Node01"
      vb.cpus = 1
      vb.memory = 1024
    end
    cfg.vm.hostname = "k8s-node01"
    cfg.vm.synced_folder ".", "/vagrant"
    cfg.vm.network "private_network", ip: "192.168.32.11"
    cfg.vm.network "forwarded_port", guest: 22, host: 24022, auto_correct: false, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 80, host: 40080
    cfg.vm.network "forwarded_port", guest: 8080, host: 48080
    cfg.vm.provision "shell", path: "sshd_config.sh"
  end

   # Node02
   config.vm.define:"k8s-node02" do |cfg|
     cfg.vm.box = "generic/ubuntu2004"
     cfg.vm.provider:virtualbox do |vb|
         vb.name="K8s-Node02"
         vb.cpus = 1
         vb.memory = 1024
     end
     cfg.vm.hostname = "k8s-node02"
     cfg.vm.synced_folder ".", "/vagrant"
     cfg.vm.network "private_network", ip: "192.168.32.12"
     cfg.vm.network "forwarded_port", guest: 22, host: 23022, auto_correct: false, id: "ssh"
     cfg.vm.network "forwarded_port", guest: 80, host: 30080
     cfg.vm.network "forwarded_port", guest: 8080, host: 38080
     cfg.vm.provision "shell", path: "sshd_config.sh"
   end

  # Master
  config.vm.define:"k8s-master" do |cfg|
    cfg.vm.box = "generic/ubuntu2004"
    cfg.vm.provider:virtualbox do |vb|
        vb.name="K8s-Master"
        vb.cpus = 2
        vb.memory = 2048
    end
    cfg.vm.hostname = "k8s-master"
    cfg.vm.synced_folder ".", "/vagrant"
    cfg.vm.network "private_network", ip: "192.168.32.10"
    cfg.vm.network "forwarded_port", guest: 22, host: 21022, auto_correct: false, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 80, host: 10080
    cfg.vm.network "forwarded_port", guest: 8000, host: 18000
    cfg.vm.network "forwarded_port", guest: 8001, host: 18001
    cfg.vm.network "forwarded_port", guest: 8080, host: 18080
    cfg.vm.provision "shell", path: "sshd_config.sh"
  end
end
