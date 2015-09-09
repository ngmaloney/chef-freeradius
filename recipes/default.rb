#
# Cookbook Name:: freeradius
# Recipe:: default
#
# Copyright 2012, NM Consulting
#
# All rights reserved - Do Not Redistribute
#
include_recipe "freeradius::#{node[:freeradius][:install_method]}"

sqlconf = "#{node['freeradius']['dir']}/sql.conf"
ruby_block 'check_freeradius_version' do
  radius_version = `radiusd -v | head -n1`.match(/FreeRADIUS Version ([\d\.]+)/)[1].to_f
  sqlconf = "#{node['freeradius']['dir']['mods-available']}/sql" if radius_version >= 3
end

if node['freeradius']['enable_ldap'] == true
  include_recipe 'freeradius::ldap'
end

template sqlconf do
  source "sql.conf.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
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
  action [:enable, :start]
end
