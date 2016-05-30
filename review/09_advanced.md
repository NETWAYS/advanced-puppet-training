!SLIDE smbullets small
# Advanced Classes

****

Class Parameter

****

<pre>
class apache(
  Enum['running','stopped'] $ensure      = running,
  Boolean                   $enable      = true,
) {

  ...

  service { 'httpd':
    ensure => $ensure,
    enable => $enable,
  }
}
</pre>

!SLIDE smbullets small
# Advanced Classes

****

Class inheritions

****

<pre>
class apache(
  Enum['running','stopped'] $ensure      = running,
  Boolean                   $enable      = true,
  Boolean                   $ssl         = $apache::params::ssl,
) inherits apache::params {

  packages { $package:
    ensure => installed,
  }

  if $ssl {
    case $::osfamily {
      'RedHat': {
        package {'mod_ssl':
          ensure => installed,
        }
      }
      default: {
        fail("This module has no support for ssl on $::osfamily, yet")
      }
    }
  }

  ...
}
</pre>
