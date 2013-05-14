# key-updater cookbook

# Requirements

# Usage
This cookbook checks a databag defined by node["rackspace-user"]["data_bag_name"] and creates a users and updates their authorized keys file based on this information.

The following info needs to be in the keys file.

data_bag_name: 'name of data bag that contains full info'
user:          'user that needs to be the owner of the keys

# Attributes

node["rackspace-user"]["data_bag_name"] data_bag that contains user info  
node["rackspace-user"]["user"] user 'id' to pull from data_bag.

The data_bag contains the following info,

home_folder:    Users home folder	
id:             id refrenced by user attribute
password_hash:  Hashed password for the user	
remote_file:    Location of the users authorized keys file
shell:          Users shell
user:           login name for the user


# Recipes

default.rb, imports file specified in a databag

# Author

Author:: Thomas Cate (thomas.cate@rackspace.com)
