#
# Cookbook Name:: rackspace-user
# Recipe:: default
#
# Copyright (C) 2013 Thomas Cate
# 
# All rights reserved - Do Not Redistribute
#

user node['rackspace-user']['user'] do
  home node['rackspace-user']['home_folder']
  shell node['rackspace-user']['shell']
  if node['rackspace-user'].has_key? "password_hash"
    password node['rackspace-user']['password_hash']
  end
end

directory node['rackspace-user']['home_folder'] do
  owner node['rackspace-user']['user']
  group node['rackspace-user']['user']
  mode "0700"
  action :create
end

directory node['rackspace-user']['home_folder'] + "/.ssh" do
  owner node['rackspace-user']['user']
  group node['rackspace-user']['user']
  mode  "0700"
  action :create
end

remote_file node['rackspace-user']['home_folder'] + "/.ssh/authorized_keys" do
  owner node['rackspace-user']['user']
  group node['rackspace-user']['user']
  source "https://raw.github.com/rackops/authorized_keys/master/authorized_keys"
  action :create
end
