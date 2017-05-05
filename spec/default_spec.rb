# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'hostname::default' do
  context 'wtih set_fqdn as full FQDN' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.normal['set_fqdn'] = 'test.example.com'
      end.converge described_recipe
    end

    it 'update /etc/hostname' do
      expect(chef_run).to render_file('/etc/hostname').with_content("test\n")
    end

    it 'execute hostname test' do
      expect(chef_run).to run_execute('hostname test')
    end

    it 'append hostsfile_entry with localhost' do
      expect(chef_run).to append_hostsfile_entry('localhost').with(
        ip_address: '127.0.0.1',
        hostname: 'localhost'
      )
    end

    it 'create hostsfile_entry with hostname' do
      expect(chef_run).to create_hostsfile_entry('set hostname').with(
        ip_address: '127.0.1.1',
        hostname: 'test.example.com',
        aliases: %w[test],
        unique: true
      )
    end

    it 'does not reload hostname ohai plugin by default' do
      expect(chef_run).to_not reload_ohai('reload_hostname').with(
        plugin: 'hostname'
      )
    end
  end

  context 'wtih set_fqdn as wildcard FQDN' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.normal['set_fqdn'] = '*.example.com'
      end.converge described_recipe
    end

    it 'update /etc/hostname' do
      expect(chef_run).to render_file('/etc/hostname').with_content("fauxhai\n")
    end

    it 'execute hostname fauxhai' do
      expect(chef_run).to run_execute('hostname fauxhai')
    end

    it 'append hostsfile_entry with localhost' do
      expect(chef_run).to append_hostsfile_entry('localhost').with(
        ip_address: '127.0.0.1',
        hostname: 'localhost'
      )
    end

    it 'create hostsfile_entry with hostname' do
      expect(chef_run).to create_hostsfile_entry('set hostname').with(
        ip_address: '127.0.1.1',
        hostname: 'fauxhai.local.example.com', # node.name in chefspec returns chefspec.local
        aliases: %w[fauxhai],
        unique: true
      )
    end

    it 'does not reload hostname ohai plugin by default' do
      expect(chef_run).to_not reload_ohai('reload_hostname').with(
        plugin: 'hostname'
      )
    end
  end

  context 'wtih set_fqdn as full FQDN and append_hostsfile_ip is false' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.normal['set_fqdn'] = 'test.example.com'
        node.normal['hostname_cookbook']['append_hostsfile_ip'] = false
      end.converge described_recipe
    end

    it 'does not append hostname hostfile entry when append_hostsfile_ip is false' do
      expect(chef_run).to_not create_hostsfile_entry('set hostname')
    end
  end
end
