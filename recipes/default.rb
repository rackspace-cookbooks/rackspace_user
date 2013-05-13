#
# Cookbook Name:: key-updater
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

data_bag_name = node['rackspace-user']['data_bag_name']
id            = node['rackspace-user']['user']

keys = data_bag_item(data_bag_name, id)

user keys["user"] do
  home keys["home_folder"]
  shell keys["shell"]
  password keys["password_hash"]
end

directory keys["home_folder"] do
  owner keys["user"]
  group keys["user"]
  mode "0700"
  action :create
end

directory keys["home_folder"] + "/.ssh" do
  owner keys["user"]
  group keys["user"]
  mode  "0700"
  action :create
end

remote_file keys["home_folder"] + "/.ssh/authorized_keys" do
  owner keys["user"]
  group keys["user"]
  source keys["remote_file"]
  action :create
end
