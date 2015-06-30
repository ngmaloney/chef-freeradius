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

if node['freeradius']['enable_sql']
  custom_dir = "#{node['freeradius']['dir']}/sql/#{node['freeradius']['db_type']}"
  directory custom_dir do
    owner node['freeradius']['user']
    group node['freeradius']['group']
    mode 0750
    notifies :run, "execute[create-dialup-conf]", :immediately
  end
  execute "create-dialup-conf" do
    command "touch #{custom_dir}/dialup.conf"
    not_if { ::File.exists?("#{custom_dir}/dialup.conf") }
    action :nothing
  end
end

template "#{node['freeradius']['dir']}/sql.conf" do
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
