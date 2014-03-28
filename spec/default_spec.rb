# -*- coding: utf-8 -*-

require 'chefspec'

describe 'hostname::default' do
  let(:chef_run) { ChefSpec::Runner.new }

  it 'sets FQDN' do
    chef_run.node.set['set_fqdn'] = 'test.example.com'
    chef_run.converge 'hostname'

    expect(chef_run).to render_file('/etc/hostname').with_content("test\n")
    expect(chef_run).to run_execute('hostname test')
  end

  it "substitutes star to node's name" do
    chef_run.node.name 'test'
    chef_run.node.set['set_fqdn'] = '*.example.com'
    chef_run.converge 'hostname'

    expect(chef_run).to render_file('/etc/hostname').with_content("test\n")
    expect(chef_run).to run_execute('hostname test')
  end
end
