!SLIDE small
# Main Class

    @@@ Puppet
    class custom(
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


!SLIDE smbullets small
# params Subclass

    @@@ Puppet
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
* Dependencies between resources will be defined only between resources contain to the same subclass


!SLIDE small
# install Subclass

    @@@ Puppet
    class custom::install (
    ) inherits custom::params {
      package { $custom_package:
        ensure => installed,
      }
    }

* Class to do all stuff of the installation
* Contains all resources that don't enforce a service restart if they changed


!SLIDE small
# config Subclass

    @@@ Puppet
    class custom::config (
    ) inherits custom::params {
      $param1 = $custom::param1

      file { $custom_config:
        ensure => file,
        content => template('custom/custom.conf.erb'),
      }
    }

* Contains all resources that don't enforce a service restart if they changed


!SLIDE small
# service Subclass

    @@@ Puppet
    class custom::service (
    ) inherits custom::params {
      $ensure = $custom::ensure
      $enable = $custom::enable

      service { $custom_service:
        ensure => $ensure,
        enable => $enable,
      }
    }

* Finally the service subclass handles all resources to manage the service respectively services
