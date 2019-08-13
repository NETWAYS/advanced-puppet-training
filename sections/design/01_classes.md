!SLIDE smbullets small
# 'main' Class

    @@@Puppet
    class custom (
      Enum['running','stopped'] $ensure = running,
      Boolean                   $enable = true,
      String                    $param1 = $custom::params::param1,
    ) inherits custom::params {

      include custom::install, custom::config, custom::service

      Class['custom::install']
        -> Class['custom::config']
        ~> Class['custom::service']
    }

* Split off your class in subclasses
* Define dependencies between these classes
* Dependencies between resources will be defined only between resources contain to the same subclass


!SLIDE smbullets small
# 'params' Subclass

    @@@Puppet
    class custom::params {
      $param1 = 'value'

      case $::osfamily {
        'redhat': {
          $custom_package = 'custom'
          $custom_config  = '/etc/custom.conf'
          $custom_service = 'custom'
        }
        ...
        default: {
          fail('Your operatingsystem is not supported, yet.')
        }
      }
    }

* Used for develop plattform independency modules
* Set default values for parameters in the main class
* Inherits variable scope to all child classes
* Defines no resources

~~~SECTION:handouts~~~

This design pattern is based on Puppet 3 best practice. Puppet 4 allows to define a lookup for data
based on hiera or a internal function which can replace this design pattern when Puppet 4 has widely
replaced Puppet 3.

Puppet 4's data in module works in a similar fashion like enviroment data you will learn in a later chapter.

~~~ENDSECTION~~~


!SLIDE small
# 'install' Subclass

    @@@Puppet
    class custom::install (
    ) inherits custom::params {
      package { $custom_package:
        ensure => installed,
      }
    }

* Class to do all stuff of the installation
* Contains all resources that don't enforce a service restart if they changed


!SLIDE small
# 'config' Subclass

    @@@Puppet
    class custom::config (
    ) inherits custom::params {
      $param1 = $custom::param1

      file { $custom_config:
        ensure => file,
        content => template('custom/custom.conf.erb'),
      }
    }

* Contains all resources that do enforce a service restart if they changed


!SLIDE small
# 'service' Subclass

    @@@Puppet
    class custom::service (
      $ensure = $custom::ensure
      $enable = $custom::enable
    ) inherits custom::params {

      service { $custom_service:
        ensure => $ensure,
        enable => $enable,
      }
    }

* Finally the service subclass handles all resources to manage the service respectively services


!SLIDE smbullets
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

Rework the `main` apache class:

    @@@Puppet
    training@agent $ cd /home/training/puppet/modules
    training@agent $ vim apache/manifests/init.pp
    class apache (
      Enum['running','stopped'] $ensure = running,
      Boolean                   $enable = true,
      Boolean                   $ssl    = $apache::params::ssl,
      Hash                      $vhosts = {},
    ) inherits apache::params {

      class{'apache::install':}
      ->
      class{'apache::config':}
      ~>
      class{'apache::service':}
    }

    training@agent $ puppet parser validate apache/manifests/init.pp

Rework the `apache::params` class:

    @@@Puppet
    training@agent $ vim apache/manifests/params.pp
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

    training@agent $ puppet parser validate apache/manifests/params.pp

~~~PAGEBREAK~~~

Create the `apache::install` class:

    @@@Puppet
    training@agent $ vim apache/manifests/install.pp
    class apache::install (
    ) inherits apache::params {

      $ssl = $apache::ssl

      package { $apache_package:
        ensure => installed,
      }

      if $ssl {
        case $::osfamily {
          'RedHat': {
            package {'mod_ssl':
              ensure => installed,
              notify => Class['apache::service'],
            }
          }
          default: {
            fail("This module has no support for ssl on $::osfamily, yet")
          }
        }
      }
    }

    training@agent $ puppet parser validate apache/manifests/install.pp

Create the `apache::config` class:

    @@@Puppet
    training@agent $ vim apache/manifests/config.pp
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
        apache::vhost { $name:
          * => $vhost,
        }
      }
    }

    training@agent $ puppet parser validate apache/manifests/config.pp

~~~PAGEBREAK~~~

Create the `apache::service` class:

    @@@Puppet
    training@agent $ vim apache/manifests/service.pp
    class apache::service (
    ) inherits apache::params {

      $ensure = $apache::ensure
      $enable = $apache::enable

      service { $apache_service:
        ensure => $ensure,
        enable => $enable,
      }
    }

    training@agent $ puppet parser validate apache/manifests/service.pp

Modify the defined resource `apache::vhost`:

    @@@Puppet
    training@agent $ vim apache/manifests/vhost.pp
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

    training@agent $ puppet parser validate apache/manifests/vhost.pp
    training@agent $ sudo puppet apply --noop apache/examples/init.pp
    training@agent $ sudo puppet apply apache/examples/init.pp
