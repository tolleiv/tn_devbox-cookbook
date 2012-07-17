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

include_recipe "tn_devbox::basic"

nextVarnishPort = 6081

node[:tn_devbox].each do |host|
  Chef::Log.info("Enable new host: #{host[:name]}")

  ['htdocs', 'config'].each do |dir|
      directory "/var/www/#{host[:name]}/#{dir}" do
        group "www-data"
        owner "root"
        mode 0775
        recursive true
      end
  end

  dev_apache_site host[:name]
  dev_nginx_site host[:name] do
    varnishPort nextVarnishPort
  end
  dev_varnish_site host[:name] do
    port nextVarnishPort
  end unless !host[:varnish]
  dev_mysql_db_permissions host[:name].gsub(/.local/, '')

  template "/var/www/#{host[:name]}/htdocs/index.php" do
    source "php-index.php.erb"
    mode 0664
    action :create_if_missing
  end
end

apache_site "000-default" do
  enable false
end

nginx_site "default" do
  enable false
end
