#
# Cookbook Name:: aoe
# Recipe:: default
#
# Copyright 2012, Tolleiv Nietsch
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"
include_recipe "git"
include_recipe "vim"
include_recipe "php::package"
['apc', 'curl', 'gd', 'mysql', 'sqlite3'].each do |mod|
  include_recipe "php::module_#{mod}"
end
include_recipe "apache2"
['rewrite', 'deflate', 'php5', 'headers', 'expires', 'status'].each do |mod|
  include_recipe "apache2::mod_#{mod}"
end
include_recipe "mysql::server"
include_recipe "nginx"
include_recipe "varnish"


############# Apache Configuration ##############
template "apache2-deflate" do
  path "/etc/apache2/conf.d/deflate"
  source "apache2-deflate.erb"
  mode 0644
end
template "apache2-mpmprefork" do
  path "/etc/apache2/conf.d/prefork_mpm"
  source "apache2-mpmprefork.erb"
  mode 0644
end
template "apache2-keepalive" do
  path "/etc/apache2/conf.d/keepalive"
  source "apache2-keepalive.erb"
  mode 0644
end
template "apache2-security" do
  path "/etc/apache2/conf.d/security"
  source "apache2-security.erb"
  mode 0644
end

############# MySQL Configuration ##############
template "mysql-charset" do
  path "/etc/mysql/conf.d/aoe_charset.cnf"
  source "mysql-charset.erb"
end

