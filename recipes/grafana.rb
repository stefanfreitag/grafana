#
# Cookbook Name:: prometheus
# Recipe: grafana
#

# Create prometheus user
user node['grafana']['user'] do
  system true
  shell '/bin/false'
  home node['grafana']['dir']
end

# Download grafana to local directory
remote_file node['grafana']['local'] do
  source node['grafana']['url']
  owner node['grafana']['user']
  group node['grafana']['group']
  mode '0755'
  action :create
end

# Extract grafana to directory
execute 'Extract grafana' do
  command "tar xzvf #{node['grafana']['local']} -C /opt"
  cwd '/tmp'
end

execute 'Change ownership' do
  command "chown -R #{node['grafana']['user']}:#{node['grafana']['group']} /opt/grafana-5.2.2"
  cwd '/tmp'
end

link '/opt/grafana' do
  owner node['grafana']['user']
  group node['grafana']['group']
  to '/opt/grafana-5.2.2'
  link_type :symbolic
end

template '/etc/init.d/grafana' do
  source 'grafana.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

service 'grafana' do
  supports status: true, restart: true, reload: true
  action %i[enable start]
end
