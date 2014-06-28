if not node['site-forgetypo3org']['amqp']['password'].nil? then
  amqp_pass = node['site-forgetypo3org']['amqp']['password']

else

  if Chef::Config[:solo]
    Chef::Log.warn "AMQP connection will be disabled as running inside of chef-solo!"
    amqp_pass = "fooo"
  else

    # read AMQP password from chef-vault
    #include_recipe "chef-vault"
    amqp_pass = chef_vault_password(node['site-forgetypo3org']['amqp']['server'], node['site-forgetypo3org']['amqp']['user'])

  end

end

Chef::Log.info "AMQP user info will fetched from data_bags for #{node['site-forgetypo3org']['amqp']['user']}"

user_data_bag = search(:users, "id:#{node['site-forgetypo3org']['amqp']['user']}")
if user_data_bag.empty?
  # we didn't find the user that is configured via node[site-forgetypo3org][amqp][user] in data_bags/user"
  # If you read this you probably have to add a json for the mentioned user in data_bags/users
  msg = 'AMQP user "' + node['site-forgetypo3org']['amqp']['user'] + '" could not be found in data_bags/users. Either add the user or change the attribute node["site-forgetypo3org"]["amqp"]["user"]'
  Chef::Log.error msg
  raise msg
end


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