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
    # vi hosts.pp
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

    # puppet apply --noop hosts.pp
    # puppet apply hosts.pp
