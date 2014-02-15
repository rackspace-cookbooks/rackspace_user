#
# Cookbook Name:: rackspace_user
# Recipe:: additional_users
#
# Copyright (C) 2013 Rackspace
#
# All rights reserved - Do Not Redistribute
#

node.default['rackspace_sudo']['config']['authorization']['sudo']['include_sudoers_d'] = true

include_recipe 'rackspace_sudo'

# rubocop:disable BlockNesting
if node['rackspace_user']['users']
  node['rackspace_user']['users'].each do |user, data|
    # This is an overarching kill switch that overrides enable
    if node['rackspace_user']['users'][user]['scrub'] == true
      user user do
        action :remove
      end

      unless node['rackspace_user']['users'][user]['home'].nil?
        directory node['rackspace_user']['users'][user]['home'] do
          action :delete
          recursive true
        end
      end

      if node['rackspace_user']['users'][user]['sudo'] == true
        rackspace_sudo user do
          user user
          action :remove
        end
      end
    else # END KILLSWITCH
      unless node['rackspace_user']['users'][user]['enabled'] == false
        if node['rackspace_user']['users'][user]['group'].nil?
          user_group = user
        else
          group node['rackspace_user']['users'][user]['group'] do
            action :create
          end
          user_group = node['rackspace_user']['users'][user]['group']
        end

        user user do
          unless node['rackspace_user']['users'][user]['uid'].nil?
            uid node['rackspace_user']['users'][user]['uid']
          end

          unless node['rackspace_user']['users'][user]['password'].nil?
            password node['rackspace_user']['users'][user]['password']
          end

          unless node['rackspace_user']['users'][user]['group'].nil?
            gid node['rackspace_user']['users'][user]['group']
          end

          shell node['rackspace_user']['users'][user]['shell']
          home node['rackspace_user']['users'][user]['home']
          comment node['rackspace_user']['users'][user]['note']
          supports manage_home: false
          action :create
        end

        unless node['rackspace_user']['users'][user]['groups'].nil?
          node['rackspace_user']['users'][user]['groups'].each do |supp_group|
            Chef::Log.info('Trying to add group: ' + supp_group)
            group supp_group do
              action :create
              members user
              append true
            end
          end
        end

        if node['rackspace_user']['users'][user]['manage_home'] == true
          directory node['rackspace_user']['users'][user]['home'] do
            owner user
            group user_group
            mode '0755'
            recursive true
            action :create
          end

          unless node['rackspace_user']['users'][user]['authorized_keys'].nil?
            directory node['rackspace_user']['users'][user]['home'] + '/.ssh' do
              owner user
              group user_group
              mode '0700'
              action :create
            end

            template node['rackspace_user']['users'][user]['home'] + '/.ssh/authorized_keys' do
              cookbook node['rackspace_user']['templates_cookbook']['authorized_keys']
              source 'authorized_keys.erb'
              mode '0600'
              owner user
              group user_group
              variables(
                keys: node['rackspace_user']['users'][user]['authorized_keys']
              )
            end
          end
        end

        if node['rackspace_user']['users'][user]['sudo'] == true
          rackspace_sudo user do
            user user
            if node['rackspace_user']['users'][user]['sudo_nopasswd'] == true
              nopasswd true
            else
              nopasswd false
            end
          end
        else 
          rackspace_sudo user do
            user user
            action :remove
          end
        end    

      end
    end
  end
end
# rubocop:enable BlockNesting
