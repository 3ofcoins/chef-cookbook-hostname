# -*- coding: utf-8 -*-

require 'chefspec'

describe 'hostname::vmware' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge 'hostname::vmware' }
end
