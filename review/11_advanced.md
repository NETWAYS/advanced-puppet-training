!SLIDE smbullets small
# Parameterized Classes

    @@@ Puppet
    class apache(
      Enum['running','stopped'] $ensure        = running,
      Boolean                   $enable        = true,
      Boolean                   $default_vhost = false,
      Hash[String, String]      $vhosts        = {},
    ) {
    ...
      service { 'httpd':
        ensure => $ensure,
        enable => $enable,
      }
    }

* Classes can take parameters to change their behaviour
* The parameters can have a defined data type with Puppet 4
* Also with parameters a class is still a singleton


!SLIDE smbullets small
# Inheritance

    @@@ Puppet
    class apache(
      Boolean    $ssl = $apache::params::ssl,
    ) inherits apache::params {

      if $ssl {
        case $::osfamily {
          'RedHat': {
            package {'mod_ssl':
              ensure => installed,
            }
          }
          default: {
            fail("This module has no support on $::osfamily, yet")
          }
        }
      }
      ...
    }

**Note:** The only style guide conform usage of inheritance is for `params`.
