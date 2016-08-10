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

    @@@Puppet
    @@sshkey { $hostname:
      type => dsa,
      key  => $sshdsakey,
    }

Collect exported resources:

    @@@Puppet
    Sshkey <<| |>>


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

* Objective:
 * Create a haproxy configuration using exported resources
* Steps:
 * Expand the `apache` module on `agent-centos.localdomain`
 * Declare an exported resource `haproxy::balancermember` in `config.pp`
 * Push your configuration to `master`
 * Install `puppetlabs-haproxy` and `puppetlabs-concat` module with r10k on `puppet.localdomain`
 * Collect exported resources via `site.pp`
 * Push your configuration to `production`
 * Deploy the `production` environment with r10k
 * Trigger Puppet run and test your configuration on `agent-centos.localdomain`


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Exported Resources

## Objective:

****

* Create a haproxy configuration using exported resources

## Steps:

****

* Expand the `apache` module on `agent-centos.localdomain`
* Declare an exported resource `haproxy::balancermember` in `config.pp`
* Push your configuration to `master`
* Install `puppetlabs-haproxy` and `puppetlabs-concat` module with r10k on `puppet.localdomain`
* Collect exported resources via `site.pp`
* Push your configuration to `production`
* Deploy the `production` environment with r10k
* Trigger Puppet run and test your configuration on `agent-centos.localdomain`


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Exported Resources

****

Declare an exported resource `haproxy::balancermember` in `config.pp`:

    @@@Sh
    $ cd /home/training/puppet/modules
    $ vim apache/manifests/config.pp
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

    $ puppet parser validate apache/manifests/config.pp

Push your configuration to `master`:

    @@@Sh
    $ cd /home/training/puppet/modules/apache
    $ git add manifests/config.pp
    $ git commit -m 'haproxy'
    $ git push origin master

Install `puppetlabs-haproxy` and `puppetlabs-concat` module with r10k on `puppet.localdomain`:

    @@@Sh
    $ cd /home/training/puppet
    $ vim Puppetfile
    mod "puppetlabs/stdlib", :latest
    mod 'apache',
      :git => '/home/training/apache.git'
    mod "puppetlabs/haproxy", :latest
    mod "puppetlabs/concat", :latest

    $ git add Puppetfile

Collect exported resources via `site.pp`:

    @@@Sh
    $ vim manifests/site.pp
    node "agent-centos.localdomain" {
      include apache
      include haproxy

      haproxy::listen { "$::fqdn":
        collect_exported => false,
        ipaddress        => "$::ipaddress_enp0s8",
        ports            => '8080',
      }

      Haproxy::Balancermember <<| |>>
    }

    $ puppet parser validate manifests/site.pp
    $ git add manifests/site.pp

Push your configuration to `production`:

    $ git commit -m 'haproxy module'
    $ git push origin production

Deploy the `production` environment with r10k:

    @@@Sh
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

Trigger Puppet run and test your configuration on `agent-centos.localdomain`:

    @@@Sh
    $ sudo puppet agent -t

Test HAProxy redirect to Apache:

    http://192.168.56.102:8080
