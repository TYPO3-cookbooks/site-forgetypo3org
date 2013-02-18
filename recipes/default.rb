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

%w{
  libxslt-dev
  libxml2-dev
}.each do |pkg|
  package pkg
end

####################################
# nginx
####################################

# replace the nginx-site file

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "redmine::nginx"

rewind :template => "/etc/nginx/sites-available/#{node.redmine.hostname}" do
  cookbook_name "site-forgetypo3org"
end

template "/etc/nginx/redirects.conf" do
  source "nginx/redirects.erb"
  notifies :reload, "service[nginx]"
end

####################################
# php
####################################

include_recipe "php"