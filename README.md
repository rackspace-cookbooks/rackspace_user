# key-updater cookbook

# Requirements

# Usage
This cookbook checks a databag defined by node["key-updater"]["data_bag_name"] and creates a users and updates their authorized keys file based on this information.

The following info needs to be in the keys file.

data_bag_name: 'name of data bag that contains full info'
user:          'user that needs to be the owner of the keys

# Attributes

I plan on adding an attribute for which databag to reference

# Recipes

default.rb, imports file specified in a databag

# Author

Author:: Thomas Cate (thomas.cate@rackspace.com)
