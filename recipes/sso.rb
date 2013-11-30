#
# Cookbook Name:: site-forgetypo3org
# Recipe:: sso
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

['sso', 'sso/tmp', 'sso/log'].each do |dir|
  directory "/home/redmine/#{dir}" do
    owner "redmine"
    group "redmine"
  end
end

['sigsso.conf', 'redmine_sso.php', 'sigsso_public.key'].each do |file|
  template "/home/redmine/sso/#{file}" do
    source "sso/#{file}.erb"
    owner "redmine"
    group "redmine"
    mode 0644
  end
end

template "#{node['redmine']['deploy_to']}/current/public/scripts/sigsso.php" do
  source "sso/sigsso.php.erb"
  owner "redmine"
  group "redmine"
end

template "#{node['redmine']['deploy_to']}/current/public/scripts/loginredirect.php" do
  source "sso/loginredirect.php.erb"
  owner "redmine"
  group "redmine"
end