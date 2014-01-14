describe_recipe 'rackspace-user::additional_users' do
  it 'creates test_user1 authorized_keys' do
    file("#{node[:rackspace][:users][:test_user1][:home]}/.ssh/authorized_keys").must_exist
  end

  it 'creates test_user1' do
    user(node[:rackspace][:users][:test_user1]).must_exist
  end
end 
