require 'spec_helper'


network = "/etc/sysconfig/network"
hosts = "/etc/hosts"


hostname = 'test'
domain = 'example.com'
fqdn = "#{hostname}.#{domain}"


case RSpec.configuration.os
when 'redhat', 'centos'
	# Test for file and contains test
	describe file(network) do
		it { should be_file }
		it { should contain "HOSTNAME=#{fqdn}" }
	end
end


# Test hosts file for correct entry
describe file(hosts) do 
	it { should be_file }
	it { should be_readable }
	it { should contain "127.0.1.1	#{fqdn} #{hostname}" }
end


# Test hostname command returns correct values
describe command('hostname -d') do
	it { should return_stdout domain}
end


# Test hostname for fqdn
describe command('hostname -f') do
	it { should return_stdout fqdn}
end

