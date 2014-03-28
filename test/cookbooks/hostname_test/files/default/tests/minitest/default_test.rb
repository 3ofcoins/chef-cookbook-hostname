require File.expand_path('../support/helpers', __FILE__)

describe "recipe::hostname::default" do
  include Helpers::HostnameTest

  it 'sets hostname' do
    assert { shell_out!('hostname').stdout.strip == node['hostname'] }
  end

  it 'sets FQDN' do
    assert { shell_out!('hostname -f').stdout.strip == node['fqdn'] }
  end

  it 'sets dnsdomainname' do
    assert { shell_out!('dnsdomainname').stdout.strip == node['domain'] }
  end
end
