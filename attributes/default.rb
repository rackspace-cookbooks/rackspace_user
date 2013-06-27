default["rackspace-user"]["user"] = 'rack'
default["rackspace-user"]["remote_file"] = 'https://raw.github.com/rackops/authorized_keys/master/authorized_keys'
default["rackspace-user"]["shell"] = '/bin/bash'
default["rackspace-user"]["home_folder"] = "/home/#{node['rackspace-user']['user']}"
