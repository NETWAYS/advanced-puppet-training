!SLIDE small
# Resource Relationships

    @@@ Puppet
    Package['ntp'] -> File['/etc/ntp.conf'] ~> Service['ntpd']

Same as:

    @@@ Puppet
    package { 'ntp':
      ensure => present,
    } ->
    file { '/etc/ntp.conf':
      ensure => file,
      mode   => '0600',
      source => 'puppet:///modules/ntp/ntp.conf',
    } ~>
    service { 'ntpd':
      ensure => running,
      enable => true,
    }

Same as (but not good style according to the style guide):

    @@@ Puppet
    Service['ntpd'] <~ File['/etc/ntp.conf'] <- Package['ntp']
