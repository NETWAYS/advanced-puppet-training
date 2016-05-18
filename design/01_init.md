!SLIDE smbullets small
# Modularized Classes

!SLIDE smbullets small
# Main Class

<pre>
class custom(
  $ensure = running,
  $enable = true,
  $param1 = $custom::params::param1,
) inherits custom::params {

  include custom::install, custom::config, custom::service

  Class['custom::install']
    -> Class['custom::config']
    ~> Class['custom::service']
}
</pre>

!SLIDE smbullets small
# Subclass params

<pre>
class custom::params {
  $param1 = 'value'

  $custom_package = 'custom'
  $custom_config  = '/etc/custom.conf'
  $custom_service = 'custom'
}
</pre>

!SLIDE smbullets small
# Subclass install

<pre>
class custom::install inherits custom::params {
  package { $custom_package:
    ensure => installed,
  }
}
</pre>

!SLIDE smbullets small
# Subclass config

<pre>
class custom::config inherits custom::params {
  $param1 = $custom::param1

  file { $custom_config:
    ensure => file,
    content => template('custom/custom.conf.erb'),
  }
}
</pre>

!SLIDE smbullets small
# Subclass service

<pre>
class custom::service inherites custom::params {
  $ensure = $custom::ensure
  $enable = $custom::enable

  service { $custom_service:
    ensure => $ensure,
    enable => $enable,
  }
}
</pre>

