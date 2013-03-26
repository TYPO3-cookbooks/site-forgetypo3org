amqp_username  = node[:redmine][:amqp][:username]

amqp_user = search('users', 'id:' + amqp_username).first
if amqp_user.nil?
  Chef::Log.error "Search for id:#{amqp_username} in 'users' data bag did not return anything!"
  raise("No entry id#{amqp_username} found in 'users' data bag")
end




# remove pre- from environment (if we're eg in pre-production, which almost equals production)
environment = node.chef_environment.gsub(/pre-/, '')

# get all passwords for this environment
all_password_data = Chef::EncryptedDataBagItem.load("passwords", environment)

# remove . from fqdn
server_cleaned = node['site-forgetypo3org']['amqp']['server'].gsub(/\./, "")
user = node['site-svntypo3org']['amqp']['user']

Chef::Log.info "Looking for password rabbitmq.#{server_cleaned}.#{}"
if all_password_data["rabbitmq"][server_cleaned][user].nil?
  raise "Cannot find password for rabbitmq user '#{user}' in data bag 'passwords/#{node["chef_environment"]}'."
end

amqp_pass = all_password_data["rabbitmq"][server_cleaned][user]



template "#{node['redmine']['deploy_to']}/shared/config/amqp.yml" do
  source "redmine/amqp.yml"
  owner "redmine"
  group "redmine"
  mode "0664"
  variables(
      :server    => node['site-forgetypo3org']['amqp']['server'],
      :username  => node['site-forgetypo3org']['amqp']['user'],
      :password  => amqp_pass,
      :vhost     => node['site-forgetypo3org']['amqp']['vhost']
  )
end
