# rackspace-user cookbook
The default recipe creates a `rack` user and updates the authorized_keys file.

The additional_users recipe creates users based on a data structure in node["rackspace"]["users"].

For example,  
node["rackspace"]["users"]["kilroy"] =  
  "enabled" => true,  
  "sudo" => "passwordless",  
  "password" => "$6$passwordhashasdf/.asdf./asdf./awe/awletr.lj/sldj",  
  "note" => "Kilroy was here",  
  "home" => "/home/kilroy",  
  "shell": "/bin/bash",  
  "authorized_keys" => [  
    "AAAAB3NzaC1yc2EAAAADAQABAAABAQC3vjtkdo1eO9eM22+vTza2+fne0yW4WnCnX3zhvOZY4V3covLXWDQN/X04U7+DIMwYeKMr9JQrd4kwvzXA0o44851Vk4AG7rP/E0982HcZ7ScK+K8W2h73uwV75VgTWzqiyy/FxLVr0Ut41UGb6wTUfTOHqvVgiDuB7Hxum3++MRUlDm7vEjRuMyGQQ2ma8fVFUgwL+5R00+reOJ2/+C2UJcwrKINwu/lBQkD6WBLxfu+Aw4sHI+LRzjO8pSmCletVwIA4yWONWPvKO34cxccmhxcjHTrwgVoUeBLOkP9nUT7MJA5W9fcA+7jt18d+SsGaj4b4u5skShaMAicgfnTF"  
  ]  
  
  
# Requirements
No other cookbooks are required for the base role, minitest-handler is recommended to execute the tests in ./files/default/tests/minitest/

# Usage
By default this will make a passwordless ssh user named rack using the ssh keys from a remote file. All of this can be modified through attributes. 

The additional_users recipe allows you to create regular users based off of a data hash.

# Attributes

    node["rackspace-user"]["user"] user to create  
    node["rackspace-user"]["remote_file"] remote file that contains ssh keys  
    node["rackspace-user"]["shell"] users shell  
    node["rackspace-user"]["home_folder"] users home folder  


    node["rackspace"]["users"] hash of users, keys are usernames.
    enabled: Boolean true/false, determines if the user is actually created.
    sudo: Boolean true/false, determines if they get sudo access.
    password: This takes a password hash for the users login.
    note: This fills the user comment field.
    home: Sets the users home directory and creates it.
    shell: Sets the users shell.
    authorized_keys: This is an array of available ssh public keys for this user.


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
