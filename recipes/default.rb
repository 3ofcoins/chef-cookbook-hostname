#
# Cookbook Name:: hostname
# Recipe:: default
#
# Copyright 2011, Maciej Pasternacki
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require 'chef/util/file_edit'

fqdn = node[:set_fqdn]
if fqdn
  fqdn =~ /^([^.]+)/
  hostname = $1
  changed = false

  file '/etc/hostname' do
    content "#{hostname}\n"
    mode "0644"
  end

  if node[:hostname] != hostname
    execute "hostname #{hostname}"
    changed=true
  end

  if node[:fqdn] != fqdn
    hosts_line = "#{node[:ipaddress]} #{fqdn} #{hostname}"
    ruby_block 'put_fqdn_in_hosts' do
      block do
        hosts = Chef::Util::FileEdit.new("/etc/hosts")
        if hosts.search_line(/^#{node[:ipaddress]}/)
          hosts.search_file_replace_line(/^#{node[:ipaddress]}/, hosts_line)
        else
          hosts.append_line(hosts_line)
        end
        hosts.write_file
      end
      only_if { File.read('/etc/hosts').grep(/^#{hosts_line}/).empty? }
    end
    changed = true
  end

  ohai "reload" if changed
else
  log "Please set the set_fqdn attribute to desired hostname" do
    level :warn
  end
end
