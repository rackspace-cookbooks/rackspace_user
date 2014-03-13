# rackspace_user cookbook
`recipe[rackspace_user::default]` recipe does nothing - `recipe[rackspace_user::rack_user]` recipe creates a `rack` user and updates the authorized_keys file.

The additional_users recipe creates users based on a data structure in `node['rackspace_user']['users']`.

For example,  
```ruby
node['rackspace_user']['users']['kilroy'] = {
  "enabled" => true,  
  "sudo" => true,  
  "sudo_nopasswd" => true,  
  "manage_home" => true,  
  "password" => "$6$passwordhashasdf/.asdf./asdf./awe/awletr.lj/sldj",  
  "note" => "Kilroy was here",  
  "home" => "/home/kilroy",  
  "shell" => "/bin/bash",  
  "authorized_keys" => [  
    "AAAAB3NzaC1yc2EAAAADAQABAAABAQC3vjtkdo1eO9eM22+vTza2+fne0yW4WnCnX3zhvOZY4V3covLXWDQN/X04U7+DIMwYeKMr9JQrd4kwvzXA0o44851Vk4AG7rP/E0982HcZ7ScK+K8W2h73uwV75VgTWzqiyy/FxLVr0Ut41UGb6wTUfTOHqvVgiDuB7Hxum3++MRUlDm7vEjRuMyGQQ2ma8fVFUgwL+5R00+reOJ2/+C2UJcwrKINwu/lBQkD6WBLxfu+Aw4sHI+LRzjO8pSmCletVwIA4yWONWPvKO34cxccmhxcjHTrwgVoUeBLOkP9nUT7MJA5W9fcA+7jt18d+SsGaj4b4u5skShaMAicgfnTF"
  ]
}
```
  
# Requirements
rackspace_sudo cookbook is required, minitest-handler is recommended to execute the tests in ./files/default/tests/minitest/

# Usage

- recipe[rackspace_user::default] - By default this cookbook will do nothing. 
- recipe[rackspace_user::rack_user] - rack_user.rb will make a passwordless ssh user named rack using the ssh keys from a remote file. 
- recipe[rackspace_user::additional_users] - additional_users.rb will create regular users based off of a data hash.

# Attributes

`node['rackspace_user']['users']` - hash of users, keys are usernames.
`node['rackspace_user']['users']["#{user}"]` - user to create  
`node['rackspace_user']['users']["#{user}"]['remote_file']` - remote file that contains ssh keys  
`node['rackspace_user']['users']["#{user}"]['shell']` - user's shell  
`node['rackspace_user']['users']["#{user}"]['home_folder']` - user's home folder  


`node['rackspace_user']['users']["#{user}"]['enabled']` - Boolean true/false, determines if the user is actually created.  
`node['rackspace_user']['users']["#{user}"]['manage_home']` - Boolean true/false, determines if the home directory is created.  
`node['rackspace_user']['users']["#{user}"]['sudo']` - Boolean true/false, true enables sudo, false/nil disables sudo.
`node['rackspace_user']['users']["#{user}"]['sudo_nopasswd']` - Boolean true/false, if sudo == true and sudo_nopasswd == true, passwordless sudo is enabled. false/nil disables passwordless sudo.
`node['rackspace_user']['users']["#{user}"]['password']` - This takes a password hash for the user's login.
`node['rackspace_user']['users']["#{user}"]['note']` - This fills the user comment field.
`node['rackspace_user']['users']["#{user}"]['home']` - Sets the user's home directory and creates it.
`node['rackspace_user']['users']["#{user}"]['shell']` - Sets the user's shell.
`node['rackspace_user']['users']["#{user}"]['authorized_keys']` - This is an array of available ssh public keys for this user.

# Recipes
- default.rb - does nothing.
- rack_user.rb - makes a passwordless ssh user named rack using the ssh keys from a remote file.
- additional_users.rb - creates regular users based off of a data hash.

# Contributing

* See the guide [here](https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md)

# Testing

* See the guide [here](https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md)

# License and Authors

- Author:: Thomas Cate (thomas.cate@rackspace.com)
- Author:: Zachary Deptawa (zachary.deptawa@rackspace.com)
- Author:: Ted Neykov (ted.neykov@rackspace.com)

```text
Copyright 2014, Rackspace, US Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
