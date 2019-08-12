!SLIDE smbullets
# Resources Resource Type 

* Metatype that can manage other resource types
* Purge unmanaged resources


!SLIDE small
# Resources Usage

Example usage:

    @@@Puppet
    resources { 'user':
      purge              => true,
      unless_system_user => true,
    }

Help:

    @@@Puppet
    $ puppet describe resources


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Resources Resource Type

* Objective:
 * Use the `resource` resource type to purge host entries
* Steps:
 * Create a new manifest called `hosts`
 * Manage the host entries for `localhost4.localdomain4` and `localhost6.localdomain6`
 * Manage the host entries for `agent-centos.localdomain` and `puppet.localdomain`
 * Purge all other host entries
 * Apply your manifest


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Resources Resource Type

## Objective:

****

* Use the `resource` resource type to purge host entries

## Steps:

****

* Create a new manifest called `hosts`
* Manage the host entries for `localhost4.localdomain4` and `localhost6.localdomain6`
* Manage the host entries for `agent-centos.localdomain` and `puppet.localdomain`
* Purge all other host entries
* Apply your manifest


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Resources Resource Type

****

    @@@Sh
    $ cd /home/training/puppet/modules
    $ vim apache/manifests/hosts.pp
    class apache::hosts {
      host { 'localhost4.localdomain4':
        ip           => '127.0.0.1',
        host_aliases => [ 'localhost4','localhost.localdomain','localhost' ],
      }
    
      host { 'localhost6.localdomain6':
        ip           => '::1',
        host_aliases => [ 'localhost6','localhost.localdomain','localhost' ],
      }
    
      host { 'agent-centos.localdomain':
        ip           => '192.168.56.102',
        host_aliases => [ 'agent-centos' ],
      }
    
      host { 'puppet.localdomain':
        ip           => '192.168.56.101',
        host_aliases => [ 'puppet' ],
      }
    
      resources { 'host':
        purge => true,
      }
    }

    $ vim apache/examples/hosts.pp
    include apache::hosts

    $ puppet parser validate apache/manifests/hosts.pp
    $ sudo puppet apply --noop apache/examples/hosts.pp
    $ sudo puppet apply apache/examples/hosts.pp
