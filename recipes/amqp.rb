if not node['site-forgetypo3org']['amqp']['password'].nil? then
  amqp_pass = node['site-forgetypo3org']['amqp']['password']

else

  if Chef::Config[:solo]
    Chef::Log.warn "AMQP connection will be disabled as running inside of chef-solo!"
    amqp_pass = "fooo"
  else

    # read AMQP password from chef-vault
    chef_gem "chef-vault"
    require 'chef-vault'

    amqp_server_cleaned = node['site-forgetypo3org']['amqp']['server'].gsub(/\./, '')
    amqp_user = node['site-forgetypo3org']['amqp']['user']
    # look for the vault entry like mqtypo3org-forgetypo3org in the passwords data bag
    vault = ChefVault::Item.load("passwords", "#{amqp_server_cleaned}-#{amqp_user}")
    amqp_pass = vault['amqp_user']

  end

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