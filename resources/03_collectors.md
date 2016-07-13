!SLIDE small
# Resource Collectors

    @@@ Puppet
    Type <| [Attribute] [Search Expression] [Search Key] |>

* Select a group of resources by searching the attributes of every resource in the catalog
* Collectors realize virtual resources

Realize all virtual user resources:

    @@@ Puppet
    User <| |>

Realize all system administrators:

    @@@ Puppet
    User <| groups == 'sysadmin' |>

Realize all users tagged with Nuremberg:

    @@@ Puppet
    User <| tag == 'nuremberg' |>


!SLIDE smbullets
# Search Expressions

* **==** (equality search)<br/>
Match if the value of the attribute is identical to the search key
* **!=** (non-equality search)<br/>
Match if the value of the attribute is not identical to the search key
* **and**<br/>
Both operands must be search expressions that evaluate as true
* **or**<br/>
Either operand can be a search expression that evaluates as true


!SLIDE small
# Realizing with Collectors

    @@@ Puppet
    @user { 'luke': ensure => present, }

    @user { 'james':
      ensure => present,
      groups  => 'dba',
    }

    @user { 'jeff':
      ensure => present,
      groups  => 'sysadmin',
    }

    @user { 'brad':
      ensure => present,
      groups  => 'webadmins',
    }

    User <| (groups == 'dba' or groups == 'sysadmin')
            or title == 'luke' |>

The users luke, james, jeff will be created, but brad will not.


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Resource Collectors

* Objective:
 * Use resource collectors for all packages
* Steps:
 * Switch package resources in `apache::install` to virtual resources
 * Realize package resources
 * Test and apply your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Resource Collectors

## Objective:

****

* Use resource collectors for all packages

## Steps:

****

* Switch package resources in `apache::install` to virtual resources
* Realize package resources
* Test and apply your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Resource Collectors

****

    @@@ Sh
    $ vim /home/training/puppet/modules/apache/manifests/install.pp
    class apache::install (
    ) inherits apache::params {
      $ssl = $apache::ssl

      @package { $apache_package:
        ensure => installed,
      }

      if $ssl {
        case $::osfamily {
          'RedHat': {
            @package {'mod_ssl':
              ensure => installed,
            }
          }
          default: {
            fail("This module has no support for ssl on $::osfamily, yet")
          }
        }
      }

      Package <| |>
    }

    $ puppet parser validate /home/training/puppet/modules/apache/manifests/install.pp
    $ sudo puppet apply --noop /home/training/puppet/modules/apache/examples/init.pp
    $ sudo puppet apply /home/training/puppet/modules/apache/examples/init.pp


!SLIDE small
# Optional Usage of Resource Collectors 

For Dependencies:

    @@@ Puppet
    Yumrepo['epel'] -> Package <| tag == 'epel' |>
    Yumrepo['puppetlabs'] -> Package <| tag == 'puppetlabs' |>

To provide defaults (will override attributes):

    @@@ Puppet
    User <| group == sysadmin |> {
      shell => '/usr/bin/bash',
    }
    Package <| |> {
      provider => 'yum',
    }
