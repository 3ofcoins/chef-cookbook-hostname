# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'hostname::vmware' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge described_recipe }
end
