describe_recipe 'rackspace_user::default' do
  it 'creates the authorized_keys file' do
    file("#{node[:rackspace_user][:rack_user][:home_folder]}/.ssh/authorized_keys").must_exist
  end

  it 'creates the rack user' do
    user(node[:rackspace_user][:rack_user][:user]).must_exist
  end
end 
