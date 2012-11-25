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
    "default" => %w{ libfreeradius2 freeradius-common libperl5.10 libssl0.9.8 libc6 libltdl7 }
  },
  [ "centos" ] => {
    "default" => %w{ openssl-devel }
  },
  "default" => %w{ }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
