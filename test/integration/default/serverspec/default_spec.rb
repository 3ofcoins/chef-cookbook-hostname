require 'serverspec'

set :backend, :exec

puts os

# 'sets hostname to "test"'
hostname_cmd = if os[:family] == 'freebsd'
                 'hostname -s'
               else
                 'hostname'
               end
describe command(hostname_cmd) do
  its(:stdout) { should eq("test\n") }
end

# 'sets FQDN to "test.example.com"'
describe command('hostname -f') do
  its(:stdout) { should eq("test.example.com\n") }
end

# 'sets dnsdomainname to "example.com"'
describe command('dnsdomainname'), if: os[:family] != 'freebsd' do
  its(:stdout) { should eq("example.com\n") }
end
