!SLIDE subsectionnonum
# concat

!SLIDE smbullets
# concat Overview 

* Builds files from fragments
* Defined resource type
* Included in puppetlabs/concat modules


!SLIDE smbullets small
# concat Usage

    @@@ Puppet
    $zone_file = '/var/named/training.zone'

    concat{ $zone_file:
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }

    concat::fragment{ 'managed by puppet zone file':
      target => $zone_file,
      source => 'puppet:///modules/named/managed.txt',
      order  => '01',
    }

    concat::fragment{ 'training_zone_header':
      target  => $zone_file,
      content => template('dns/zone_header.erb'),
      order   => '05',
    }
