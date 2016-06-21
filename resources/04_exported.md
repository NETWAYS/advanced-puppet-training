!SLIDE smbullets
# Exported Resources

* Export resources to a database (PuppetDB)
* Collect and use them on other nodes


!SLIDE noprint
# Exported Resources

<center><img src="../_images/resources/exported_resources.png" style="width:503px;height:425px;" alt="Exported Resources"/></center>


!SLIDE printonly
# Exported Resources

<center><img src="../_images/resources/exported_resources.png" style="width:480px;height:406px;" alt="Exported Resources"/></center>


!SLIDE smbullets small
# Exported Resources Syntax

Declare exported resources:

    @@@ Puppet
    @@sshkey { $hostname:
      type => dsa,
      key  => $sshdsakey,
    }

Collect exported resources:

    @@@ Puppet
    Sshkey <<| |>>


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

* Objective:
 * Create a monitoring configuration using exported resources
* Steps:
 * Expand the `apache` module
 * Declare an exported resource `nagios_host`
 * Declare an exported resource `nagios_service`
 * Add a smoke test and apply your manifest
 * Create a new module called `monitoring`
 * Collect `nagios_host` and `nagios_service` resources
 * Add a smoke test and apply your manifest

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

## Objective:

****

* Create a monitoring configuration using exported resources

## Steps:

****

* Expand the `apache` module
* Declare an exported resource `nagios_host`
* Declare an exported resource `nagios_service`
* Add a smoke test and apply your manifest
* Create a new module called `monitoring`
* Collect `nagios_host` and `nagios_service` resources
* Add a smoke test and apply your manifest


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Exported Resources

****

    @@@ Puppet
    # vim /etc/puppet/modules/apache/manifests/init.pp
    class apache {
      @@nagios_host { $fqdn:
        ensure  => present,
        alias   => $hostname,
        address => $ipaddress,
        use     => "generic-host",
      }

      @@nagios_service { "check_ping_${hostname}":
        check_command       => "check_ping!100.0,20%!500.0,60%",
        use                 => "generic-service",
        host_name           => "$fqdn",
        notification_period => "24x7",
        service_description => "${hostname}_check_ping"
      }
    }

    # vim /etc/puppet/modules/apache/examples/init.pp
    include apache

    # puppet apply --noop /etc/puppet/modules/apache/examples/init.pp
    # puppet apply /etc/puppet/modules/apache/examples/init.pp

    # vim /etc/puppet/modules/monitoring/manifests/init.pp
    class monitoring {
      Nagios_host <<||>>
      Nagios_service <<||>>
    }

    # vim /etc/puppet/modules/monitoring/examples/init.pp
    include monitoring

    # puppet apply --noop /etc/puppet/modules/monitoring/examples/init.pp
    # puppet apply /etc/puppet/modules/monitoring/examples/init.pp


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

* Objective:
 * Create a haproxy configuration using exported resources
* Steps:
 * Expand the `apache` module
 * Declare an exported resource `haproxy::balancermember` in `config.pp`
 * Install `puppetlabs-haproxy` module
 * Install `haproxy` and collect exported resources
 * Test and apply your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

## Objective:

****

* Create a haproxy configuration using exported resources

## Steps:

****

* Expand the `apache` module
* Declare an exported resource `haproxy::balancermember` in `config.pp`
* Install `puppetlabs-haproxy` module
* Install `haproxy` and collect exported resources 
* Test and apply your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Exported Resources

****

    @@@ Sh
    # vim /etc/puppet/modules/apache/manifests/config.pp
    class apache::config (
    ) inherits apache::params {
      $vhosts = $apache::vhosts

      file { $apache_config:
        ensure => file,
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/apache/httpd.conf',
      }

      @@haproxy::balancermember { 'master':
        listening_service => "${apache_service}",
        server_names      => "$::fqdn",
        ipaddresses       => "$::ipaddress",
        ports             => '80',
        options           => 'check',
      }

      $vhosts.each | String $name, Hash $vhost | {
        apache::vhost { $name :
          * => $vhost,
        }
      }
    }

    # puppet parser validate /etc/puppet/modules/apache/config.pp
    # vim /etc/puppet/modules/apache/examples/haproxy.pp
    include apache
    include haproxy
    Haproxy::Balancermember <<| |>>

    # puppet parser validate /etc/puppet/modules/apache/examples/haproxy.pp
    # puppet apply --noop /etc/puppet/modules/apache/examples/haproxy.pp
    # puppet apply /etc/puppet/modules/apache/examples/haproxy.pp
