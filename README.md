# rackspace-user cookbook
This cookbook checks a databag defined by node["rackspace-user"]["data_bag_name"] and creates a users and updates their authorized keys file based on this information.

# Requirements
No other cookbooks are required for the base role, minitest-handler is recommended to execute the tests in ./files/default/tests/minitest/

# Usage

By default this will make a passwordless ssh user named rack using the ssh keys from https://raw.github.com/rackops/authorized_keys/master/authorized_keys. All of this can be modified through attributes


# Attributes

node["rackspace-user"]["user"] user to create
node["rackspace-user"]["password_hash"] password hash for user.  
node["rackspace-user"]["remote_file"] remote file that contains ssh keys 
default["rackspace-user"]["shell"] users shell
default["rackspace-user"]["home_folder"] users home folder 

# Recipes

default.rb, creates user and pulls in key file

# License and Authors

Author:: Thomas Cate (thomas.cate@rackspace.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
