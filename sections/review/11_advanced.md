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
* The parameters can have a defined data type
* Also with parameters a class is still a singleton
