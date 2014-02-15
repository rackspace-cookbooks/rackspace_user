name             'rackspace_user'
maintainer       'Rackspace, US Inc.'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license          'Apache 2.0'
description      'Adds/configures users'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

recipe 'rackspace_user', 'Configures users'

depends 'rackspace_sudo', '~> 3.1'

%w{redhat centos ubuntu debian}.each do |os|
  supports os
end
