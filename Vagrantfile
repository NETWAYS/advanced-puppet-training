# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

DOMAIN_NAME = 'localdomain'

Vagrant.configure('2') do |config|
  # Disable updates of vbguest tools
  config.vbguest.auto_update = false if Vagrant.has_plugin?('vagrant-vbguest')

  config.vm.provider :virtualbox do |vb|
    vb.memory = '512'
    vb.vcpu = 2
  end

  new_linux_vm config, 'puppet', '192.168.56.101' do |host|
    host.vm.provider :virtualbox do |vb|
      vb.memory = 2560
    end
  end

  new_linux_vm config, 'agent-centos', '192.168.56.102'

  config.vm.provision :hosts, sync_hosts: true
end

def new_vm(config, name, ip)
  config.vm.define name do |host|
    host.vm.hostname = "#{name}.#{DOMAIN_NAME}"
    host.vm.network :private_network, ip: ip

    host.vm.provider :virtualbox do |vb|
      vb.customize [
        'modifyvm',  :id,
        '--groups',  '/Advanced Puppet',
        '--audio',   'none',
        '--usb',     'on',
        '--usbehci', 'off'
      ]
    end

    yield(host) if block_given?
  end
end

def new_linux_vm(config, name, ip)
  new_vm config, name, ip do |host|
    host.vm.box = 'bento/centos-7.6'

    host.vm.provision :shell, path: 'vagrant/bootstrap.sh'
    # host.vm.provision :shell, path: 'vagrant/puppet-modules.sh'

    # provision_puppet host

    yield(host) if block_given?
  end
end

def provision_puppet(host)
  host.vm.provision 'puppet' do |puppet|
    # Note: only works with vboxsf
    puppet.manifests_path = ['vm', '/vagrant/puppet']
    puppet.options = '--show_diff --hiera_config /vagrant/puppet/hiera.yaml'
  end
end
