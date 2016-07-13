!SLIDE smbullets
# Resources Resource Type 

* Metatype that can manage other resource types
* Purge unmanaged resources


!SLIDE small
# Resources Usage

Example usage:

    @@@ Puppet
    resources { 'user':
      purge              => true,
      unless_system_user => true,
    }

Help:

    @@@ Puppet
    # puppet describe resources


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Resources Resource Type

* Objective:
 * Use the `resource` resource type to purge host entries
* Steps:
 * Create a new manifest called `hosts`
 * Manage the host entries for `localhost` and `localhost6`
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
* Manage the host entries for `localhost` and `localhost6`
* Purge all other host entries
* Apply your manifest


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Resources Resource Type

****

    @@@ Sh
    $ vim /home/training/puppet/modules/apache/manifests/hosts.pp
    class apache::hosts {
      host {'localhost.localdomain':
        ip           => '127.0.0.1',
        host_aliases => [ 'localhost' ],
      }
    
      host {'localhost6.localdomain6':
        ip           => '::1',
        host_aliases => 'localhost6',
      }
    
      resources { 'host':
        purge => true,
      }
    }

    $ vim /home/training/puppet/modules/apache/examples/hosts.pp
    include apache::hosts

    $ puppet parser validate /home/training/puppet/modules/apache/manifests/hosts.pp
    $ sudo puppet apply --noop /home/training/puppet/modules/apache/examples/hosts.pp
    $ sudo puppet apply /home/training/puppet/modules/apache/examples/hosts.pp
