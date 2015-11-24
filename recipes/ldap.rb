template "#{node['freeradius']['dir']}/ldap" do
  source "ldap.erb"
  owner node['freeradius']['user']
  group node['freeradius']['group']
  mode 0600
  notifies :restart, "service[#{node['freeradius']['service']}]", :immediately
end

modules_path = (node['platform_version'].to_f >= 7) ? "mods-enabled" : "modules"
link "/etc/raddb/#{modules_path}/ldap" do
  to "#{node['freeradius']['dir']}/ldap"
  link_type :symbolic
end
