template "#{node['freeradius']['dir']}/modules/ldap" do
  source "ldap.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end
