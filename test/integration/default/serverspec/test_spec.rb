# -*- coding: utf-8 -*-

require 'serverspec'

set :backend, :exec

describe file('/etc/hostname-test') do

  its(:content) { should eq "test\ntest.example.com\n" }

end
