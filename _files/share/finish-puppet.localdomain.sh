#!/bin/bash

yum -t -y -e 0 remove facter puppet
rm -Rf /etc/puppet
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -t -y -e 0 install puppet-agent
ln -s /opt/puppetlabs/puppet/bin/{augtool,facter,mco,puppet,rake} /usr/bin/

echo "[Unit]
Description=Puppet master
Wants=basic.target
After=basic.target network.target

[Service]
EnvironmentFile=-/etc/sysconfig/puppetagent
EnvironmentFile=-/etc/sysconfig/puppet
EnvironmentFile=-/etc/default/puppet
ExecStart=/opt/puppetlabs/puppet/bin/puppet master $PUPPET_EXTRA_OPTS --no-daemonize
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process

[Install]
WantedBy=multi-user.target" >> /usr/lib/systemd/system/puppetmaster.service

systemctl enable puppet
systemctl start puppet

systemctl enable puppetmaster
systemctl start puppetmaster

puppet module install puppetlabs-puppetdb

echo "node 'puppet.localdomain' {
  class { 'puppetdb':
    manage_firewall => false,
    listen_address  => '192.168.56.101',
  }

  class { 'puppetdb::master::config':
    puppet_service_name     => 'puppetmaster',
    manage_report_processor => true,
    enable_reports          => true,
  }
}

node default {
}" >> /etc/puppetlabs/code/environments/master/manifests/site.pp

puppet agent -t

history -c
history -w
