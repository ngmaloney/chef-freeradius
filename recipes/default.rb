#
# Cookbook Name:: freeradius
# Recipe:: default
#
# Copyright 2012, NM Consulting
#
# All rights reserved - Do Not Redistribute
#
include_recipe "freeradius::#{node[:freeradius][:install_method]}"

if node['freeradius']['enable_ldap'] == true
  include_recipe 'freeradius::ldap'
end

template "#{node['freeradius']['dir']}/sql.conf" do
  source "sql.conf.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end

link '/etc/raddb/mods-enabled/sql' do
  to "#{node['freeradius']['dir']}/sql.conf"
  link_type :symbolic
  only_if { node.platform_version.to_f >= 7 }
end

template "#{node['freeradius']['dir']}/clients.conf" do
  source "clients.conf.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end

template "#{node['freeradius']['dir']}/radiusd.conf" do
  source "radiusd.conf.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  variables auth_log: node['freeradius']['log']['auth']
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end

template "#{node['freeradius']['dir']}/sites-available/default" do
  source "default.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end

template "#{node['freeradius']['dir']}/sites-available/inner-tunnel" do
  source "inner-tunnel.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end

service node['freeradius']['service'] do
  supports :restart => true, :status => false, :reload => false
  action [:enable]
end
