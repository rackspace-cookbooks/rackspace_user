#
# Cookbook Name:: rackspace-user
# Recipe:: additional_users
#
# Copyright (C) 2013 Rackspace
# 
# All rights reserved - Do Not Redistribute
#

if node['rackspace']['users']
  node['rackspace']['users'].each do |user, data|
    unless node['rackspace']['users']["#{user}"]['enabled'] == false
      if node['rackspace']['users']["#{user}"]['group'].nil?
        user_group = "#{user}"
      else
        group node['rackspace']['users']["#{user}"]['group'] do
          action :create
        end
        user_group = node['rackspace']['users']["#{user}"]['group']
      end

      user "#{user}" do
        unless node['rackspace']['users']["#{user}"]['uid'].nil?
          uid node['rackspace']['users']["#{user}"]['uid']
        end

        unless node['rackspace']['users']["#{user}"]['password'].nil?
          password node['rackspace']['users']["#{user}"]['password']
        end

        unless node['rackspace']['users']["#{user}"]['group'].nil?
          gid node['rackspace']['users']["#{user}"]['group']
        end

        shell node['rackspace']['users']["#{user}"]['shell']
        home node['rackspace']['users']["#{user}"]['home']
        comment node['rackspace']['users']["#{user}"]['note']
        supports :manage_home=>false
        action :create
      end

      unless node['rackspace']['users']["#{user}"]['groups'].nil?
        node['rackspace']['users']["#{user}"]['groups'].each do |supp_group|
          Chef::Log.info("Trying to add group: " + supp_group)
          group supp_group do
            action :create
            members "#{user}"
            append true
          end
        end
      end

      if node['rackspace']['users']["#{user}"]['manage_home'] == true
        directory node['rackspace']['users']["#{user}"]['home'] do
          owner "#{user}"
          group user_group
          mode "0755"
          recursive true
          action :create
        end
      
        unless node['rackspace']['users']["#{user}"]['authorized_keys'].nil?
          directory node['rackspace']['users']["#{user}"]['home'] + "/.ssh" do
            owner "#{user}"
            group user_group
            mode "0700"
            action :create
          end

          template node['rackspace']['users']["#{user}"]['home'] + "/.ssh/authorized_keys" do
            source "authorized_keys.erb"
            mode "0600"
            owner "#{user}"
            group user_group
            variables ({
              :keys => node['rackspace']['users']["#{user}"]['authorized_keys']
              })
          end          
        end        
      end
      
      if node['rackspace']['users']["#{user}"]['sudo'] == true
        sudo "#{user}" do
          user "#{user}"
          nopasswd true
        end
      end
    end
  end
end

node.default['authorization']['sudo']['include_sudoers_d'] = true

include_recipe "sudo"

prefix = node['authorization']['sudo']['prefix']
begin
  t = resources(:template => "#{prefix}/sudoers" )
  t.source "sudoers.erb"
  t.cookbook "rackspace-user"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template #{prefix}/sudoers to modify"
end

include_recipe "sudo"
