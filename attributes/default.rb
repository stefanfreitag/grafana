#
# Cookbook Name:: grafana
# Attribute:: default
#

default['grafana']['url'] = 'https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.2.linux-amd64.tar.gz'

# System user to use for grafana
default['grafana']['user'] = 'grafana'

# System group to use for grafana
default['grafana']['group'] = 'grafana'

# Name of the stored tar.gz on local system
default['grafana']['local'] = '/tmp/grafana-5.2.2.linux-amd64.tar.gz'

# Home directory of the grafana user
default['grafana']['dir'] = '/opt/grafana'
