#
# Cookbook Name:: grafana
# Attribute:: default
#

# Grafana version to install
default['grafana']['version'] = '5.2.2'

# Download URL for Grafana
default['grafana']['url'] = "https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-#{node['grafana']['version']}.linux-amd64.tar.gz"

# System user to use for grafana
default['grafana']['user'] = 'grafana'

# System group to use for grafana
default['grafana']['group'] = 'grafana'

# Name of the stored tar.gz on local system
default['grafana']['local'] = "/tmp/grafana-#{node['grafana']['version']}.linux-amd64.tar.gz"


# Home directory of the grafana user
default['grafana']['dir'] = '/opt/grafana'

# Log directory
default['grafana']['log_dir'] = '/var/log/grafana'


default['grafana']['conf_dir'] = "#{node['grafana']['dir']}/conf/"


## ini file configuration
# format is the following [section][key] = value
# with value being either
# - the real value
# - a hash { comment: 'a comment', disable: true|false, value: 'the real value' } with disable: true to add the ; prefix
#
# Grafana has pretty good default value, the following default attributes are only here to show how to configure grafana via attributes

# no section parameters
default['grafana']['ini'][nil]['app_mode'] = 'production'

default['grafana']['ini']['database']['type'] = {
  comment: "Either mysl, postgres, sqlite3, it's your choice",
  disable: false,
  value: 'sqlite3',
}
default['grafana']['ini']['database']['host'] = '127.0.0.1:3306'
default['grafana']['ini']['database']['name'] = 'grafana'
default['grafana']['ini']['database']['user'] = 'root'
default['grafana']['ini']['database']['password'] = ''
default['grafana']['ini']['database']['ssl_mode'] = {
  comment: 'For "postgres" only, either "disable", "require" or "verify-full"',
  disable: true,
  value: 'disable',
}
default['grafana']['ini']['database']['path'] = {
  comment: 'For sqlite3 only, path relative to data_path setting',
  disable: false,
  value: 'grafana.db',
}
default['grafana']['ini']['paths'] = {
  data: node['grafana']['data_dir'],
  logs: node['grafana']['log_dir'],
  plugins: node['grafana']['plugins_dir'],
}

default['grafana']['ini']['auth.ldap']['enabled'] = {
  comment: '',
  disable: true,
  value: false,
}
default['grafana']['ini']['auth.ldap']['config_file'] = {
  disable: true,
  value: '/etc/grafana/ldap.toml',
}

# server
default['grafana']['ini']['server']['protocol'] = 'http'
default['grafana']['ini']['server']['http_port'] = 3000
default['grafana']['ini']['server']['domain'] = 'localhost'
