!SLIDE small
# Variables

Assignment:

    @@@ Puppet
    $variable = 'value'
    $httpd_confdir = '/etc/httpd/conf.d'

**Note:** No reassignment!

Access:

* Local scope:

    $httpd_confdir

* Top scope (facts):

    $::osfamily

* Out-of-Scope:

    $apache::params::confdir


!SLIDE noprint
# Scopes

<center><img src="../_images/scope-euler-diagram.png" style="width:687px;height:560px;" alt="Scopes"></center>


!SLIDE printonly
# Scopes

<center><img src="../_images/scope-euler-diagram.png" style="width:480px;height:391px;" alt="Scopes"></center>


!SLIDE small
# Variable Example (1/2)

    @@@ Puppet
    class apache {
      include apache::params

      $package = $apache::params::package
      $config  = $apache::params::config
      $service = $apache::params::service

      package { $package:
        ensure => installed,
      }

      file { $config:
        ensure => file,
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/apache/httpd.conf',
      }
     ...
    
!SLIDE small
# Variable Example (2/2)

    @@@ Puppet
    ...
      service { 'httpd':
        ensure    => running,
        enable    => true,
        name      => $service,
        subscribe => File[$config],
      }
    }



    class apache::params {
      $package = 'httpd'
      $config  = '/etc/httpd/conf/httpd.conf'
      $service = 'httpd'
    }
