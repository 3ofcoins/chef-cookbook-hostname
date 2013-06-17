require File.expand_path('../support/helpers', __FILE__)

describe "recipe::hostname::default" do
  include Helpers::HostnameTest

  it 'sets hostname to "test"' do
    assert { shell_out!('hostname').stdout.strip == 'test' }
  end

  it 'sets FQDN to "test.example.com"' do
    assert { shell_out!('hostname -f').stdout.strip == 'test.example.com' }
  end

  it 'sets dnsdomainname to "example.com"' do
    assert { shell_out!('dnsdomainname').stdout.strip == 'example.com' }
  end
end
