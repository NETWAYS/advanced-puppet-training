!SLIDE smbullets
# Exported Resources

* Export resources to a database (PuppetDB)
* Collect and use them on other nodes


!SLIDE
# Exported Resources

<center><img src="../_images/resources/exported_resources.png" style="width:429px;height:468px;" alt="Exported Resources"/></center>


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
 * Create a haproxy configuration using exported resources
* Steps:
 * Install `puppetlabs-haproxy` module
 * Expand the `apache` module
 * Declare an exported resource `haproxy::balancermember` in `config.pp`
 * Install `haproxy` and collect exported resources
 * Push and test your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

## Objective:

****

* Create a haproxy configuration using exported resources

## Steps:

****

* Install `puppetlabs-haproxy` module
* Expand the `apache` module
* Declare an exported resource `haproxy::balancermember` in `config.pp`
* Install `haproxy` and collect exported resources 
* Push and test your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Exported Resources

****

    @@@ Sh
    $ puppet module install puppetlabs-haproxy
    $ vim /home/training/puppet/modules/apache/manifests/config.pp
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
        ipaddresses       => "$::ipaddress_enp0s8",
        ports             => '80',
        options           => 'check',
      }

      $vhosts.each | String $name, Hash $vhost | {
        apache::vhost { $name :
          * => $vhost,
        }
      }
    }

    $ puppet parser validate /home/training/puppet/modules/apache/config.pp
    $ vim /home/training/puppet/modules/apache/examples/haproxy.pp
    include apache
    include haproxy

    haproxy::listen { "$::fqdn":
      collect_exported => false,
      ipaddress        => "$::ipaddress_enp0s8",
      ports            => '8080',
    }

    Haproxy::Balancermember <<| |>>

    $ puppet parser validate /home/training/puppet/modules/apache/examples/haproxy.pp
    $ sudo puppet apply --noop /home/training/puppet/modules/apache/examples/haproxy.pp
    $ sudo puppet apply /home/training/puppet/modules/apache/examples/haproxy.pp
    $ vim /home/training/puppet/manifests/site.pp
    include apache
    include haproxy

    haproxy::listen { "$::fqdn":
      collect_exported => false,
      ipaddress        => "$::ipaddress_enp0s8",
      ports            => '8080',
    }

    Haproxy::Balancermember <<| |>>

    $ puppet parser validate /home/training/puppet/manifests/site.pp
    $ cd /home/training/puppet/
    $ git status
    $ git add manifests/
    $ git add modules/
    $ git commit -m 'initial commit'
    $ git push origin master 
    $ sudo puppet agent -t

Test HAProxy redirect to Apache:

    http://192.168.56.102:8080
