maintainer       "Tolleiv Nietsch"
maintainer_email "info@tolleiv.de"
license          "Apache 2.0"
description      "Install the default LAMP stack in my preffered development flavor"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ apache2 git nginx varnish mysql vim }.each do |cb|
  depends cb
end

