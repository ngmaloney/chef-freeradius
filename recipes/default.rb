#
# Cookbook Name:: freeradius
# Recipe:: default
#
# Copyright 2012, NM Consulting
#
# All rights reserved - Do Not Redistribute
#
include_recipe "freeradius::#{node[:freeradius][:install_method]}"

template "#{node['freeradius']['dir']}/sql.conf" do
  source "sql.conf.erb"
  owner "freerad"
  group "freerad"
  mode 0600
  notifies :restart, 'service[freeradius]', :immediately
end

service "freeradius" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end
