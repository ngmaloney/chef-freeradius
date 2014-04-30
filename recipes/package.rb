#
# Cookbook Name:: freeradius
# Recipe:: package
#
# Copyright 2011, Hexa
#
# All rights reserved - Do Not Redistribute
#

pkgs = value_for_platform(
  [ "debian" ] => {
    "default" => %w{ freeradius freeradius-common freeradius-utils freeradius-postgresql libdbi-perl libfreeradius2 libnet-daemon-perl libperl5.10 libplrpc-perl libpython2.6
  ssl-cert }
  },
  [ "ubuntu" ] => {
    "default" => %w{ freeradius freeradius-common freeradius-utils libfreeradius2 }
  },
  [ "centos" ] => {
    "default" => %w{ freeradius2 freeradius2-utils }
  },
  "default" => %w{ }
)

ldap_pkgs = value_for_platform(
  [ "debian" ] => {
    "default" => %w{ freeradius-ldap }
  },
  [ "ubuntu" ] => {
    "default" => %w{ freeradius-ldap }
  },
  [ "centos" ] => {
    "default" => %w{ freeradius2-ldap }
  },
  [ "default" ] => {
    "default" => %w{ }
  },
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

if node['freeradius']['enable_ldap'] == true
  ldap_pkgs.each do |pkg|
    package pkg do
      action :install
    end
  end
end
