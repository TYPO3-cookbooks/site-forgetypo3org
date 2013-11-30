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
# include main recipe
####################################

include_recipe "redmine"


####################################
# nginx
####################################

include_recipe "redmine::nginx"
include_recipe "ssl_certificates"

ssl_certificate node['site-forgetypo3org']['ssl_certificate'] do
  ca_bundle_combined true
end

# replace the nginx-site file
nginx_site = resources("template[/etc/nginx/sites-available/#{node['redmine']['hostname']}]")
nginx_site.cookbook "site-forgetypo3org"
nginx_site.variables(
    :ssl_certfile => node['ssl_certificates']['path'] + "/" + node['site-forgetypo3org']['ssl_certificate'] + ".crt",
    :ssl_keyfile  => node['ssl_certificates']['path'] + "/" + node['site-forgetypo3org']['ssl_certificate'] + ".key"
  )

template "/etc/nginx/redirects.conf" do
  source "nginx/redirects.erb"
  owner node['nginx']['user']
  mode 0644
end

####################################
# other recipes
####################################

include_recipe "site-forgetypo3org::amqp"
include_recipe "site-forgetypo3org::php"
include_recipe "site-forgetypo3org::sso"
