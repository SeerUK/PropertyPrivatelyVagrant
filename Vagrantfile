# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

# Load machine configs
config = YAML::load(File.open("machines.yml"))
machines = config["machines"]

# Configure machines
Vagrant.configure("2") do |config|
  config.vm.box = "saucy64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"

  machines.each do |machine|
    machine = machine["box"]

    config.vm.define machine["boxname"] do |box|
      box.vm.hostname = machine['hostname']
      box.vm.network "private_network", ip: machine["ip"]

      if machine.include? "forwarded_ports"
        machine["forwarded_ports"].each do |forward|
          box.vm.network "forwarded_port", guest: forward["guest"], host: forward["host"]
        end
      end

      if machine.include? "synced_folders"
        machine["synced_folders"].each do |folder|
          box.vm.synced_folder folder["host"], folder["guest"], nfs: true
        end
      end

      box.vm.provision :shell, :path => "pre.sh"

      if machine.include? "puppet_manifest"
        box.vm.provision :puppet do |puppet|
          puppet.manifests_path = "puppet/manifests"
          puppet.manifest_file  = machine["puppet_manifest"]
          puppet.module_path    = ["librarian/modules", "puppet/modules"]
          puppet.options        = "--verbose"
        end
      end
    end
  end
end
