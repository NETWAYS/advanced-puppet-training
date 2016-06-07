!SLIDE small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Module Design

* Objective:
 * Rework the `apache` module using module design guidelines
* Steps:
 * Copy `init.pp` to `install.pp`, `config.pp` and `service.pp`
 * Rework every of this four files
 * Don't forget to modify the vhost defined resource too
 * Run all the smoke tests again


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Module Design

## Objective:

****

* Rework the `apache` module using module design guidlines

## Steps:

****

* Copy `init.pp` to `install.pp`, `config.pp` and `service.pp`
* Rework every of this four files
* Don't forget to modify the vhost defined resource too
* Run all the smoke tests again

#### Expected Result:

The same should be happend as before reworked the module.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Module Design

****

## Rework the `apache` module using module design guidelines

****

Rework the main apache class:

    @@@ Puppet
    class apache(
      Enum['running','stopped'] $ensure     = running,
      Boolean                   $enable     = true,
      Boolean                   $ssl        = $apache::params::ssl,
      Hash                      $vhosts     = {},
    ) inherits apache::params {

      Class['apache::install']
        -> Class['apache::config']
        ~> Class['apache::service']
      Class['apache::install']
        ~> Class['apache::service']

      include apache::install
      include apache::config
      include apache::service
    }

Review the `apache::params` class:

    @@@ Puppet
    class apache::params {
      case $::osfamily {
       'RedHat': {
          $apache_package = 'httpd'
          $apache_configdir = '/etc/httpd'
          $apache_config  = "${apache_configdir}/conf/httpd.conf"
          $apache_service = 'httpd'
          $ssl            = true
        }
        default: {
          $apache_package   = 'apache2'
          $apache_configdir = '/etc/apache2'
          $apache_config    = "${apache_configdir}/apache2.conf"
          $apache_service   = 'apache2'
          $ssl              = false
        }
      }
    }

Create the `apache::install` class:

    @@@ Puppet
    class apache::install (
    ) inherits apache::params {
      $ssl = $apache::ssl

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

      package { $apache_package:
        ensure => installed,
      }
    }

Create the `apache::config` class:

    @@@ Puppet
    class apache::config (
    ) inherits apache::params {
      $vhosts = $apache::vhosts

      file { $apache_config:
        ensure => file,
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/apache/httpd.conf',
      }

      $vhosts.each | String $name, Hash $vhost | {
        apache::vhost { $name :
          * => $vhost,
        }
      }
    }

Create the `apache::service` class:

    @@@ Puppet
    class apache::service (
    ) inherits apache::params {

      $ensure = $apache::ensure
      $enable = $apache::enable

      service { $apache_service:
        ensure => $ensure,
        enable => $enable,
      }
   }

Modify the defined resource `apache::vhost`:

    @@@ Puppet
    define apache::vhost (
      String $ip,
      String $shortname    = $title,
      String $fullname     = "${shortname}.localdomain",
      String $documentroot = "/var/www/${fullname}",
    ) {
      include apache::params

      $configdir = $apache::params::apache_configdir

      file { "${configdir}/conf.d/${shortname}.conf":
        ensure  => file,
        content => template('apache/vhost.conf.erb'),
      }
    }
