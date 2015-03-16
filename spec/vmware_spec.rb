# -*- coding: utf-8 -*-

require 'chefspec'

describe 'hostname::vmware' do
  let(:chef_run) { ChefSpec::Runner.new.converge 'hostname::vmware' }
end
