require_recipe "mysql"
require_recipe "database"

node.override['mysql']['bind_address'] = "0.0.0.0"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

node.set_unless['site-forgetypo3org']['database_svn']['password'] = secure_password

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

# create a mysql user for every host that has the role site-svntypo3org
search(:node, "role:site-svntypo3org") do |n|
  mysql_database_user node['site-forgetypo3org']['database_svn']['username'] do
    connection mysql_connection_info
    password node['site-forgetypo3org']['database_svn']['password']
    host n[:fqdn]
    action :create
  end
end

mysql_database_user node['site-forgetypo3org']['database_svn']['username'] do
  connection mysql_connection_info
  database_name node['redmine']['database']['name']
  privileges [ :select ]
  password node['site-forgetypo3org']['database_svn']['password']
  action :grant
end
