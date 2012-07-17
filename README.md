Description
===========

Chef recipe will help to setup lamp stack development boxes with some extras.
It will actually place an nginx in front of everything and could include a varnish in the middle.


Attribute
==========

* `node[:tn_devbox][:hosts]` - List of hosts which will be configured on the box
** use :name to configure the "ServerName" / domain for the hosts
** use :varnish [true|false] to enable a varnish daemon for a specific host

Usage
=====

Package is meant to be used with a vagrant box - e.g. with such a json:

   chef.json = {
        :tn_devbox => [
            { :name => 'core.v4_7.local', :varnish => true },
            { :name => 'core.v6_0.local', :varnish => true }
        ]
    }

License and Author
==================

Author:: Tolleiv Nietsch <info@tolleiv.de>

Copyright 2012, Tolleiv Nietsch

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
