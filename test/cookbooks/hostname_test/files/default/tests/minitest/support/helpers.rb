module Helpers
  module HostnameTest
    require 'chef/mixin/shell_out'
    require 'wrong'
    include Chef::Mixin::ShellOut
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    include Wrong
  end
end
