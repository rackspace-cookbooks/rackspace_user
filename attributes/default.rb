default[:rackspace-user][:rack_user][:user_name] = 'rack'
default[:rackspace-user][:rack_user][:remote_file] = 'https://raw.github.com/rackops/authorized_keys/master/authorized_keys'
default[:rackspace-user][:rack_user][:shell] = '/bin/bash'
default[:rackspace-user][:rack_user][:home_folder] = "/home/#{node[:rackspace-user][:rack_user][:user]}"
