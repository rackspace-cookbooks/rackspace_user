default['rackspace_user']['rack_user']['user'] = 'rack'
default['rackspace_user']['rack_user']['remote_file'] = 'https://raw.github.com/rackops/authorized_keys/master/authorized_keys'
default['rackspace_user']['rack_user']['shell'] = '/bin/bash'
default['rackspace_user']['rack_user']['home_folder'] = "/home/#{node['rackspace_user']['rack_user']['user']}"

default['rackspace_user']['templates_cookbook']['authorized_keys'] = 'rackspace_user'
