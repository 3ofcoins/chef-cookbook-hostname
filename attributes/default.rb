# -*- coding: utf-8 -*-

default['hostname_cookbook']['hostsfile_ip'] = '127.0.1.1'
default['hostname_cookbook']['hostsfile_ip_interface'] = 'lo0' if platform == 'freebsd'
default['hostname_cookbook']['append_hostsfile_ip'] = true
