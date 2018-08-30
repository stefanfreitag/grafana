#
# Cookbook Name:: prometheus
# Recipe: grafana
#

# Create grafana user
user node['grafana']['user'] do
  system true
  shell '/bin/false'
  home node['grafana']['dir']
end

[node['grafana']['log_dir']].each do |dir|
  directory dir do
    owner node['grafana']['user']
    group node['grafana']['group']
    mode '0755'
    action :create
  end
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
  command "chown -R #{node['grafana']['user']}:#{node['grafana']['group']} /opt/grafana-#{node['grafana']['version']}"
  cwd '/tmp'
end

link '/opt/grafana' do
  owner node['grafana']['user']
  group node['grafana']['group']
  to "/opt/grafana-#{node['grafana']['version']}"
  link_type :symbolic
end


template ::File.join(node['grafana']['conf_dir'], 'grafana.ini') do
  source 'grafana.ini.erb'
  variables ini: node['grafana']['ini']
  group node['grafana']['group']
  mode '0644'
  sensitive true
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
