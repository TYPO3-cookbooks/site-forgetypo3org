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


include_recipe "t3-base"

####################################
# prerequisites
####################################

package ['libxslt-dev', 'libxml2-dev']

####################################
# include main recipe
####################################

include_recipe "redmine"

####################################
# directory for git repos
####################################

group 'git'

user 'git' do
  home '/var/git'
  gid 'git'
  manage_home true
  action :create
end

directory '/var/git/.ssh' do
  owner 'git'
end

file '/var/git/.ssh/authorized_keys' do
  owner 'git'
  content 'TODO copy pubkey from Gerrit server'
  action :create_if_missing
end

# location of the git repos
directory '/var/git/repositories' do
  owner 'redmine'
  group 'git'
  # must be writeable also for the 'git' user (based on the group)
  mode 0775
end


####################################
# nginx
####################################

include_recipe "redmine::nginx"

# replace the nginx-site file
nginx_site = resources("template[/etc/nginx/sites-available/#{node['redmine']['hostname']}]")
nginx_site.cookbook cookbook_name

template "/etc/nginx/redirects.conf" do
  source "nginx/redirects.erb"
  owner node['nginx']['user']
  mode 0644
  notifies :reload, 'service[nginx]'
end

template "/etc/nginx/robots.txt" do
  source "nginx/robots.erb"
  owner node['nginx']['user']
  mode 0644
end
