require 'vagrant-openstack-plugin'
require 'vagrant-berkshelf'

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  config.berkshelf.enabled = true

  # Make sure the private key from the key pair is provided
  config.ssh.private_key_path = "/home/tcate/.ssh/cbastion.key"

  config.vm.provider :openstack do |os|

    os.server_name = "tc-vagrant"
    os.username = "admin"
    os.api_key  = "0p3nst@ck"
    os.flavor   = "1"
    os.image    = "d04283e0-f9cc-4339-b794-78c7ffebc0d7"
    os.endpoint = "http://10.240.0.10:5000/v2.0/tokens"
    os.keypair_name = "tcate"
    os.ssh_username = "stack"
  end

#  config.vm.provision :chef_solo do |chef|

#      chef.add_recipe("chef-client")
#      chef.add_recipe("apt")
#      chef.add_recipe("apache2")
#  end

#  config.vm.provision :chef_client do |chef|
#    chef.chef_server_url     = "https://openchef11.stacksonstacksonstacks.com"
#    chef.validation_key_path = "/home/tcate/.ssh/openchef-validator.pem"
#  end

end
