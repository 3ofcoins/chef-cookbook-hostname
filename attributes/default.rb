# -*- coding: utf-8 -*-

default['hostname_cookbook']['hostsfile_ip'] = '127.0.1.1'
default['hostname_cookbook']['hostsfile_ip_interface'] = 'lo0' if node['platform'] == 'freebsd'
default['hostname_cookbook']['hostsfile_aliases'] = []
default['hostname_cookbook']['hostsfile_include_hostname_in_aliases'] = true
