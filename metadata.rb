name             "freeradius"
maintainer       "Nick Maloney"
maintainer_email "ngmaloney@gmail.com"
license          "All rights reserved"
description      "Installs/Configures freeradius"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.1"

%w{ ubuntu centos debian }.each do |os|
  supports os
end
