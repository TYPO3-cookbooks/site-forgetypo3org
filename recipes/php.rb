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

case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_f <= 10.04
      # Configure Brian's PPA
      # We'll install php5-fpm from the Brian's PPA backports
      apt_repository "brianmercer-php" do
        uri "http://ppa.launchpad.net/brianmercer/php5/ubuntu"
        distribution node['lsb']['codename']
        components ["main"]
        keyserver "keyserver.ubuntu.com"
        key "8D0DC64F"
        action :add
      end
      # FIXME: apt-get update didn't trigger in above
      execute "apt-get update"
    end
  when 'debian'
    # Configure Dotdeb repos
    # TODO: move this to it's own 'dotdeb' cookbook?
    # http://www.dotdeb.org/instructions/
    if node.platform_version.to_f >= 5.0
      apt_repository "dotdeb" do
        uri "http://packages.dotdeb.org"
        distribution "stable"
        components ['all']
        key "http://www.dotdeb.org/dotdeb.gpg"
        action :add
      end
    else
      apt_repository "dotdeb" do
        uri "http://packages.dotdeb.org"
        distribution "oldstable"
        components ['all']
        key "http://www.dotdeb.org/dotdeb.gpg"
        action :add
      end
      apt_repository "dotdeb-php53" do
        uri "http://php53.dotdeb.org"
        distribution "oldstable"
        components ['all']
        key "http://www.dotdeb.org/dotdeb.gpg"
        action :add
      end
    end
  when 'centos', 'redhat'
    # Configure IUS repo
    # http://rob.olmos.name/2010/08/centos-5-5-php-5-3-3-php-fpm-nginx-rpms/
    # TODO: verify this is the best repo
    yum_repository "ius" do
      url "http://dl.iuscommunity.org/pub/ius/stable/Redhat/5.5/$basearch"
      action :add
    end
end

include_recipe "php::fpm"

php_fpm 'redmine' do
  user 'redmine'
  group 'redmine'
  socket false
  port 9000
end

# suhosin
package "php5-suhosin"

template "/etc/php5/conf.d/suhosin.ini" do
  source "php/suhosin.ini"
  mode 0644
  notifies :restart, "service[php5-fpm]"
end

node.set['php']['secure_functions'] = false

package "php5-mysql"