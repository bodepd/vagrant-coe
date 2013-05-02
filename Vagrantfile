# -*- mode: ruby -*-
# vi: set ft=ruby :

# Four networks: 
# 0 - VM host NAT
# 1 - COE build/deploy
# 2 - COE openstack internal
# 3 - COE openstack external (public)


# Since puppet uses hostnames to determine which node is which
# we have a small shell provisioner to set hostnames to be
# different on each node.

Vagrant::Config.run do |config|
  config.vm.box = "precise64"

  config.vm.define :cache do |cache_config|
    cache_config.vm.box = "precise64"
    cache_config.vm.network :hostonly, "192.168.242.99"
    cache_config.vm.provision :shell do |shell|
      shell.inline = "hostname cache;echo cache > /etc/hostname;sed -i 's/precise64/cache/g' /etc/hosts; apt-get update; apt-get install apt-cacher-ng -y; cp /vagrant/01apt-cacher-ng-proxy /etc/apt/apt.conf.d; apt-get update;" 
    end
  end

  # Cobbler based "build" server
  config.vm.define :build do |build_config|
    build_config.vm.box = "precise64"
    build_config.vm.network :hostonly, "192.168.242.100"
    build_config.vm.network :hostonly, "2.2.3.10"
    build_config.vm.network :hostonly, "3.2.3.10"
    build_config.vm.provision :shell do |shell|
      shell.inline = "hostname coe-build;echo coe-build > /etc/hostname;sed -i 's/precise64/coe-build/g' /etc/hosts;cp /vagrant/dhclient.conf /etc/dhcp;cp /vagrant/01apt-cacher-ng-proxy /etc/apt/apt.conf.d; apt-get update; dhclient -r eth0 && dhclient eth0; apt-get install -y git vim puppet curl; cp /vagrant/site.pp /etc/puppet/manifests"
    end

  end

  # Openstack control server
  config.vm.define :control do |control_config|
    control_config.vm.box = "blank-coe-control"
    control_config.vm.network :hostonly, "192.168.242.10", :mac => "001122334455"
    control_config.vm.network :hostonly, "2.2.3.11"
    control_config.vm.network :hostonly, "3.2.3.11"
  end

  # Openstack compute server
  config.vm.define :compute do |compute_config|
    compute_config.vm.box = "blank-coe-compute"
    compute_config.vm.network :hostonly,  "192.168.242.21", :mac => "001122334466"
    compute_config.vm.network :hostonly, "2.2.3.12"
    compute_config.vm.network :hostonly, "3.2.3.12"
  end

end
