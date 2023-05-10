# -*- coding: utf-8 -*-

name             'hostname'
maintainer       'Maciej Pasternacki'
maintainer_email 'maciej@3ofcoins.net'
license          'MIT'
description      'Configures hostname and FQDN'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.3'

supports 'debian'
supports 'ubuntu'
supports 'freebsd'

depends 'hostsfile'

source_url 'https://github.com/3ofcoins/chef-cookbook-hostname' if respond_to?(:source_url)
issues_url 'https://github.com/3ofcoins/chef-cookbook-hostname/issues' if respond_to?(:issues_url)

chef_version '>= 12.1' if respond_to?(:chef_version)
