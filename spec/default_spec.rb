require 'chefspec'

describe 'hostname::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new }

  it 'sets FQDN' do
    chef_run.node.set['set_fqdn'] = 'test.example.com'
    chef_run.converge 'hostname'

    expect(chef_run).to create_file_with_content '/etc/hostname', "test\n"
    expect(chef_run).to execute_command "hostname test"
  end

  it "substitutes star to node's name" do
    chef_run.node.name 'test'
    chef_run.node.set['set_fqdn'] = '*.example.com'
    chef_run.converge 'hostname'

    expect(chef_run).to create_file_with_content '/etc/hostname', "test\n"
    expect(chef_run).to execute_command "hostname test"
  end
end
