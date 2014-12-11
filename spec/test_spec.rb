# -*- coding: utf-8 -*-

require 'chefspec'

describe 'hostname::test' do
  let(:chef_run) { ChefSpec::Runner.new }

  it 'creates an output file with correct data' do
    chef_run.converge 'hostname::test'

    expect(chef_run).to render_file('/etc/hostname-test').with_content("chefspec\nchefspec.local\n")
  end

end
