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

#############################
# PHP5-FPM
#############################

include_recipe "php::fpm"
package "php5-mysql"

#############################
# PHP5-FPM instance
#############################

php_fpm 'redmine' do
  user 'redmine'
  group 'redmine'
  socket false
  port 9000
end

#############################
# Weird PHP coobkook..
#############################

node.set['php']['secure_functions'] = false
