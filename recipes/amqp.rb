if Chef::Config[:solo]
  Chef::Log.warn "AMQP connection will be disabled as running inside of chef-solo!"
  amqp_pass = "fooo"

else
  Chef::Log.warn "AMQP password handling is a mess, Steffen @todo"

  # remove pre- from environment (if we're eg in pre-production, which almost equals production)
  #environment = node.chef_environment.gsub(/pre-/, '')

  # get all passwords for this environment
  #  all_password_data = Chef::EncryptedDataBagItem.load("passwords", environment)

  # remove . from fqdn
  #server_cleaned = node['amqp']['server'].gsub(/\./, "")
  #user = node['amqp']['user']

  #Chef::Log.info "Looking for password rabbitmq.#{server_cleaned}.#{}"
#  if all_password_data["rabbitmq"][server_cleaned][user].nil?
#    raise "Cannot find password for rabbitmq user '#{user}' in data bag 'passwords/#{node["chef_environment"]}'."
#  end

#  amqp_pass = all_password_data["rabbitmq"][server_cleaned][user]
end

template "#{node['redmine']['deploy_to']}/shared/config/amqp.yml" do
  source "redmine/amqp.yml"
  owner "redmine"
  group "redmine"
  mode "0664"
  variables(
      :server    => node['amqp']['server'],
      :username  => node['amqp']['user'],
      :password  => node['amqp']['password'],
      :vhost     => node['amqp']['vhost']
  )
end
