# -*- coding: utf-8 -*-
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
  hostname = Regexp.last_match[1]

  case node['platform']
  when 'freebsd'
    directory '/etc/rc.conf.d' do
      mode '0755'
    end

    rc_conf_lines = ["hostname=#{fqdn}\n"]
    if node['hostname_cookbook']['hostsfile_ip_interface']
      rc_conf_lines <<
        "ifconfig_#{node['hostname_cookbook']['hostsfile_ip_interface']}_alias=\"inet #{node['hostname_cookbook']['hostsfile_ip']}/32\"\n"
      service 'netif'
    end

    file '/etc/rc.conf.d/hostname' do
      content rc_conf_lines.join
      mode '0644'
      notifies :reload, 'service[netif]', :immediately \
        if node['hostname_cookbook']['hostsfile_ip_interface']
    end

    execute "hostname #{fqdn}" do
      only_if { node['fqdn'] != fqdn }
      notifies :reload, 'ohai[reload]', :immediately
    end

  when 'centos', 'redhat', 'amazon', 'scientific'
    hostfile = '/etc/sysconfig/network'
    ruby_block "Update #{hostfile}" do
      block do
        file = Chef::Util::FileEdit.new(hostfile)
        file.search_file_replace_line('^HOSTNAME', "HOSTNAME=#{fqdn}")
        file.write_file
      end
      notifies :reload, 'ohai[reload]', :immediately
    end
    # this is to persist the correct hostname after machine reboot
    sysctl = '/etc/sysctl.conf'
    ruby_block "Update #{sysctl}" do
      block do
        file = Chef::Util::FileEdit.new(sysctl)
        file.insert_line_if_no_match("kernel.hostname=#{hostname}", \
                                     "kernel.hostname=#{hostname}")
        file.write_file
      end
      notifies :reload, 'ohai[reload]', :immediately
    end
    execute "hostname #{hostname}" do
      only_if { node['hostname'] != hostname }
      notifies :reload, 'ohai[reload]', :immediately
    end
    service 'network' do
      action :restart
    end

  else
    file '/etc/hostname' do
      content "#{hostname}\n"
      mode '0644'
      notifies :reload, 'ohai[reload]', :immediately
    end

    execute "hostname #{hostname}" do
      only_if { node['hostname'] != hostname }
      notifies :reload, 'ohai[reload]', :immediately
    end
  end

  hostsfile_entry 'localhost' do
    ip_address '127.0.0.1'
    hostname 'localhost'
    action :append
  end

  hostsfile_entry 'set hostname' do
    ip_address node['hostname_cookbook']['hostsfile_ip']
    hostname fqdn
    aliases [hostname]
    action :create
    notifies :reload, 'ohai[reload]', :immediately
  end

  ohai 'reload' do
    action :nothing
  end
else
  log 'Please set the set_fqdn attribute to desired hostname' do
    level :warn
  end
end
