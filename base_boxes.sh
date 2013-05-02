# This will add the required base boxes
vagrant box add precise64 http://files.vagrantup.com/precise64.box
vagrant box add blank-coe-control blank-coe-control.box
vagrant box add blank-coe-compute blank-coe-compute.box 

#If you're making a new test environment you might need to do this to match
# the site.pp.

# attempt pxe boot from the second nic (the first hostonly - eth0 is NAT)
#VBoxManage modifyvm $VM --nicbootprio2 1

# pxe boot first, then disk
#VBoxManage modifyvm $VM --boot1 net
#VBoxManage modifyvm $VM --boot2 disk

# This will add the required base boxes
vagrant box add precise64 http://files.vagrantup.com/precise64.box
vagrant box add blank-coe-control blank-coe-control.box
vagrant box add blank-coe-compute blank-coe-compute.box
