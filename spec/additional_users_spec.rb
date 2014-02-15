require 'spec_helper'

describe 'rackspace_user::additional_users' do
  context 'create a test1 user' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['rackspace_user']['users']['test1']['enabled'] = true
        node.set['rackspace_user']['users']['test1']['manage_home'] = true
        node.set['rackspace_user']['users']['test1']['home'] = '/home/test1'
        node.set['rackspace_user']['users']['test1']['group'] = 'admins'
        node.set['rackspace_user']['users']['test1']['uid'] = '500'
        # rubocop:disable LineLength
        node.set['rackspace_user']['users']['test1']['authorized_keys'] = ['ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAtzhEm/e1iABdN/Ciba49/cCJ8w8S18x/U6DMXruV3Vlc99+LNJlgRfTg+dNxAN8dxv/cfhQzOWMj9uM3TPHU/iq323CCCrM+SA0aESzuuYoXDmfV0urq9bBdmJFq0KcfECM6Hzu2Bm8kaUkPwZjE3n4QAuw9P+SE3y6WDXeq+EM= test1@example.com']
        # rubocop:enable LineLength
      end.converge(described_recipe)
    end

    it 'creates the test1 user' do
      expect(chef_run).to create_user('test1')
    end

    it 'creates the admins group' do
      expect(chef_run).to create_group('admins')
    end

    it 'creates the test1 user home directory' do
      expect(chef_run).to create_directory('/home/test1').with(
        user:  'test1',
        group: 'admins'
      )
    end

    it 'creates the test1 user .ssh directory' do
      expect(chef_run).to create_directory('/home/test1/.ssh').with(
        user: 'test1',
        group: 'admins'
      )
    end

    it 'creates the test1 user authorized keys file' do
      expect(chef_run).to render_file('/home/test1/.ssh/authorized_keys').with_content(
        # rubocop:disable LineLength
        'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAtzhEm/e1iABdN/Ciba49/cCJ8w8S18x/U6DMXruV3Vlc99+LNJlgRfTg+dNxAN8dxv/cfhQzOWMj9uM3TPHU/iq323CCCrM+SA0aESzuuYoXDmfV0urq9bBdmJFq0KcfECM6Hzu2Bm8kaUkPwZjE3n4QAuw9P+SE3y6WDXeq+EM= test1@example.com'
        # rubocop:enable LineLength
      )
    end

  end
end
