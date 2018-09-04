# User and group settings

describe user('grafana') do
  it { should exist }
end

describe group('grafana') do
  it { should exist }
end

# Ports
describe port(22) do
  it { should be_listening }
end

describe port(3000) do
  it { should be_listening }
end

# Directories

describe directory('/opt/grafana') do
  its('link_path') { should eq '/opt/grafana-5.2.2' }
  its('group') { should eq 'grafana' }
  its('owner') { should eq 'grafana' }
end

describe directory('/var/log/grafana') do
  its('group') { should eq 'grafana' }
  its('owner') { should eq 'grafana' }
end

# Files

describe file('/etc/init.d/grafana') do
  it { should exist }
end

# Cleanup

describe file('/tmp/grafana-5.2.2.linux-amd64.tar.gz') do
  it { should_not exist }
end
