#
# Cookbook Name:: site-forgetypo3org
# Recipe:: default
#
# Copyright 2013, Steffen Gebert / TYPO3 Association
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


####################################
# prerequisites
####################################

%w{
  libxslt-dev
  libxml2-dev
}.each do |pkg|
  package pkg
end


####################################
# install a recent nginx version
####################################

include_recipe "nginx::repo"

####################################
# include main recipe
####################################

include_recipe "redmine"

amqp_username  = node[:redmine][:amqp][:username]

amqp_user = search('users', 'id:' + amqp_username).first
if amqp_user.nil?
  Chef::Log.error "Search for id:#{amqp_username} in 'users' data bag did not return anything!"
  raise("No entry id#{amqp_username} found in 'users' data bag")
end

template "#{node['redmine']['deploy_to']}/shared/config/amqp.yml" do
  source "redmine/amqp.yml"
  owner "redmine"
  group "redmine"
  mode "0664"
  variables(
    :server    => node[:rabbitmq][:server],
    :username  => amqp_username,
    :password  => amqp_user["password"],
    :vhost     => node[:redmine][:amqp][:vhost]
  )
end


####################################
# nginx
####################################

# replace the nginx-site file

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "redmine::nginx"

ssl_certificate node['site-forgetypo3org']['ssl_certificate']

rewind :template => "/etc/nginx/sites-available/#{node.redmine.hostname}" do
  cookbook_name "site-forgetypo3org"
  variables(
    :ssl_certfile => node['ssl_certificates']['path'] + "/" + node['site-forgetypo3org']['ssl_certificate'] + ".crt",
    :ssl_keyfile  => node['ssl_certificates']['path'] + "/" + node['site-forgetypo3org']['ssl_certificate'] + ".key"
  )
end

template "/etc/nginx/redirects.conf" do
  source "nginx/redirects.erb"
  owner node[:nginx][:user]
  mode 0644
end

####################################
# other recipes
####################################

include_recipe "site-forgetypo3org::php"
include_recipe "site-forgetypo3org::sso"
include_recipe "site-forgetypo3org::svn"
