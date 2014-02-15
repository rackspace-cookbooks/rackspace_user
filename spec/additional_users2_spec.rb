require 'spec_helper'

describe 'rackspace_user::additional_users' do
  context 'create a test2 user' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['rackspace_user']['users']['test2']['enabled'] = false
        node.set['rackspace_user']['users']['test2']['manage_home'] = false
        node.set['rackspace_user']['users']['test2']['home'] = '/home/test2'
        node.set['rackspace_user']['users']['test2']['group'] = 'test2'
        node.set['rackspace_user']['users']['test2']['uid'] = '500'
        # rubocop:disable LineLength
        node.set['rackspace_user']['users']['test2']['authorized_keys'] = ['ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAtzhEm/e1iABdN/Ciba49/cCJ8w8S18x/U6DMXruV3Vlc99+LNJlgRfTg+dNxAN8dxv/cfhQzOWMj9uM3TPHU/iq323CCCrM+SA0aESzuuYoXDmfV0urq9bBdmJFq0KcfECM6Hzu2Bm8kaUkPwZjE3n4QAuw9P+SE3y6WDXeq+EM= test2@example.com']
        # rubocop:enable LineLength
      end.converge(described_recipe)
    end

    it 'creates the test2 user' do
      expect(chef_run).to_not create_user('test2')
    end

    it 'creates the test2 group' do
      expect(chef_run).to_not create_group('test2')
    end

    it 'creates the test2 user home directory' do
      expect(chef_run).to_not create_directory('/home/test2').with(
        user:  'test2',
        group: 'test2'
      )
    end

    it 'creates the test2 user .ssh directory' do
      expect(chef_run).to_not create_directory('/home/test2/.ssh').with(
        user: 'test2',
        group: 'test2'
      )
    end

    it 'creates the test2 user authorized keys file' do
      expect(chef_run).to_not render_file('/home/test2/.ssh/authorized_keys').with_content(
        # rubocop:disable LineLength
        'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAtzhEm/e1iABdN/Ciba49/cCJ8w8S18x/U6DMXruV3Vlc99+LNJlgRfTg+dNxAN8dxv/cfhQzOWMj9uM3TPHU/iq323CCCrM+SA0aESzuuYoXDmfV0urq9bBdmJFq0KcfECM6Hzu2Bm8kaUkPwZjE3n4QAuw9P+SE3y6WDXeq+EM= test2@example.com'
        # rubocop:enable LineLength
      )
    end

  end
end
