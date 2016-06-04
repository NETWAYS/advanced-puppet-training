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
