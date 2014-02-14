require 'spec_helper'

describe 'rackspace_user::rack_user' do
  context 'create a rack user' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['rackspace_user']['rack_user']['user'] = 'rack'
        node.set['rackspace_user']['rack_user']['home_folder'] = '/home/rack'
        node.set['rackspace_user']['rack_user']['home_folder'] = '/home/rack'
      end.converge(described_recipe)
    end

    it 'creates the rack user' do
      expect(chef_run).to create_user('rack')
    end

    it 'creates the rack user home directory' do
      expect(chef_run).to create_directory('/home/rack').with(
        user:  'rack',
        group: 'rack',
      )
    end

    it 'creates the rack user authorized keys file' do
      expect(chef_run).to create_remote_file('/home/rack/.ssh/authorized_keys')
    end

  end
end
