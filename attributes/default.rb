#
# Cookbook Name:: aoe
# Recipe:: default
#
# Copyright 2012, Tolleiv Nietsch
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_attribute "apache2"
node.set[:apache][:default_site_enabled] = false
node.set[:apache][:listen_ports] = [ '81' ]
node.set[:apache][:contact] = 'admin@aoemedia.de'

include_attribute "mysql::server"
node.set[:mysql][:server_root_password] = '6z5oQIWu3dVKmDz8oYUi'

include_attribute "varnish"
node.set[:varnish][:start] = 'no'
node.set[:varnish][:listen_port] = 6681
node.set[:varnish][:admin_listen_address] = ''
node.set[:varnish][:admin_listen_port] = '6682'

default[:tn_devbox][:hosts] = []
