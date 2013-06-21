require 'chefspec'

describe 'hostname::vmware' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'hostname::vmware' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
