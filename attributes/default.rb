# OS Specific Attributes
case platform_family
when 'rhel'
  default['freeradius']['user'] = 'radiusd'
  default['freeradius']['group'] = 'radiusd'
  default['freeradius']['dir'] = '/etc/raddb'
  default['freeradius']['service'] = 'radiusd'
  default['freeradius']['logdir'] = '/var/log/radius'
  default['freeradius']['name'] = 'radiusd'
  default['freeradius']['libdir'] = '/usr/lib64/freeradius'
# Packages to install since centos 5 is freeradius 2 and centos 6 is  just freeradius
  if node.platform_version.to_f < 6
    default['freeradius']['pkgs'] = %w{ freeradius2 freeradius2-utils freeradius2-postgresql }
    default['freeradius']['ldap_pkgs'] = %w{ freeradius2-ldap }
  else
    default['freeradius']['pkgs'] = %w{ freeradius freeradius-utils freeradius-postgresql }
    default['freeradius']['ldap_pkgs'] = %w{ freeradius-ldap }
  end
when 'debian'
  default['freeradius']['user'] = 'freerad'
  default['freeradius']['group'] = 'freerad'
  default['freeradius']['dir'] = '/etc/freeradius'
  default['freeradius']['service'] = 'freeradius'
  default['freeradius']['logdir'] = '/var/log/freeradius'
  default['freeradius']['name'] = 'freeradius'
  default['freeradius']['libdir'] = '/usr/lib/freeradius'
  default['freeradius']['pkgs'] = %w{ freeradius freeradius-common freeradius-utils libfreeradius2 freeradius-postgresql }
  default['freeradius']['ldap_pkgs'] = %w{ freeradius-ldap }
when 'ubuntu'
  default['freeradius']['pkgs'] = %w{ freeradius freeradius-common freeradius-utils libfreeradius2 freeradius-postgresql }
  default['freeradius']['ldap_pkgs'] = %w{ freeradius-ldap }
else
  default['freeradius']['pkgs'] = %w{ }
  default['freeradius']['ldap_pkgs'] = %w{ }
end

default['freeradius']['install_method'] = "package"
default['freeradius']['log']['auth'] = false

# Db vars
default['freeradius']['db_type'] = 'postgresql'
default['freeradius']['db_server'] = 'localhost'
default['freeradius']['db_port'] = 5432
default['freeradius']['db_name'] = 'radius'
default['freeradius']['db_login'] = 'radius'
default['freeradius']['db_password'] = 'radius'

# Client Config
default['freeradius']['local_secret'] = 'testing1234'
default['freeradius']['enable_remote_clients'] = true
default['freeradius']['remote_secret'] = 'remote1234'
default['freeradius']['enable_sql'] = true

# Client File Config
default['freeradius']['clients'] = {
  'localhost' => {
    'ipaddr' => '127.0.0.1',
    'netmask' => '0',
    'secret' => 'default_secret',
    'nastype' => 'other'
  }
}

# LDAP Config
default['freeradius']['enable_ldap'] = false
default['freeradius']['ldap_server'] = 'ldap.example.com'
default['freeradius']['ldap_port'] = '636'
default['freeradius']['ldap_basedn'] = 'dc=example,dc=com'
default['freeradius']['ldap_set_auth_type'] = 'yes'

# Used for source installation
default['freeradius']['url'] = 'http://ftp.cc.uoc.gr/mirrors/ftp.freeradius.org/'
default['freeradius']['version'] = '2.1.10'
default['freeradius']['checksum'] = 'b72d00d8d9c237b6bc3bfe89e6ccd99a7be63e699b305325ea60e04d5ddda4fe'
default['freeradius']['prefix_dir'] = '/opt/local/freeradius'
default['freeradius']['configure_options'] = %W{--prefix=#{freeradius[:prefix_dir]}/#{freeradius[:version]} --with-openssl-includes=/usr/include/openssl --with-openssl-libraries=/usr/lib}
