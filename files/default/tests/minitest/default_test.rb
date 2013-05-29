describe_recipe 'rackspace-user::default' do
  it 'creates the authorized_keys file' do
    file("#{node['rackspace-user']['home_folder']}/.ssh/authorized_keys").must_exist
  end

  it 'creates the specified user' do
    user(node['rackspace-user']['user']).must_exist
  end
end 
