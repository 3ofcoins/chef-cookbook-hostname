# -*- coding: utf-8 -*-
require 'spec_helper'

describe 'hostname::default' do
  context 'wtih set_fqdn as full FQDN' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
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
        aliases: %w(test),
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
      ChefSpec::SoloRunner.new do |node|
        node.normal['set_fqdn'] = '*.example.com'
      end.converge described_recipe
    end

    it 'update /etc/hostname' do
      expect(chef_run).to render_file('/etc/hostname').with_content("chefspec\n")
    end

    it 'execute hostname chefspec' do
      expect(chef_run).to_not run_execute('hostname chefspec')
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
        hostname: 'chefspec.local.example.com', # node.name in chefspec returns chefspec.local
        aliases: %w(chefspec),
        unique: true
      )
    end

    it 'does not reload hostname ohai plugin by default' do
      expect(chef_run).to_not reload_ohai('reload_hostname').with(
        plugin: 'hostname'
      )
    end
  end
end
