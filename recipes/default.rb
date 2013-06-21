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

fqdn = node['set_fqdn']
if fqdn
  fqdn = fqdn.sub('*', node.name)
  fqdn =~ /^([^.]+)/
  hostname = $1

  file '/etc/hostname' do
    content "#{hostname}\n"
    mode "0644"
    notifies :reload, "ohai[reload]"
  end

  execute "hostname #{hostname}" do
    only_if { node['hostname'] != hostname }
    notifies :reload, "ohai[reload]"
  end

  hostsfile_entry "localhost" do
   ip_address "127.0.0.1"
   hostname "localhost"
   action :create
  end

  hostsfile_entry "set hostname" do
    ip_address "127.0.1.1"
    hostname fqdn
    aliases [ hostname ]
    action :create
    notifies :reload, "ohai[reload]"
  end

  ohai "reload" do
    action :nothing
  end
else
  log "Please set the set_fqdn attribute to desired hostname" do
    level :warn
  end
end
