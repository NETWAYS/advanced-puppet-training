!SLIDE small
# Variables

Assignment:

    @@@ Puppet
    $variable = 'value'
    $httpd_confdir = '/etc/httpd/conf.d'

**Note:** No reassignment!

Local Scope:

    @@@ Puppet
    $httpd_confdir

Facts and top scope:

    @@@ Puppet
    $facts['os'], $trusted['certname'], $::environment
    $::os, $::osfamily, $::mountpoints['/']['filesystem']

Out-of-Scope:

    @@@ Puppet
    $apache::params::confdir

~~~SECTION:handouts~~~

***

~~~PAGEBREAK~~~

You can omit the leading `::` notation when there is no local scoped variable with the same name.

Also see the documentation:

* https://puppet.com/docs/puppet/latest/lang_facts_builtin_variables.html
* https://puppet.com/docs/puppet/latest/lang_facts_accessing.html
* https://puppet.com/docs/puppet/latest/lang_scope.html

~~~ENDSECTION~~~


!SLIDE noprint
# Scopes

<center><img src="./_images/scope-euler-diagram.png" style="width:687px;height:560px;" alt="Scopes"></center>


!SLIDE printonly
# Scopes

<center><img src="./_images/scope-euler-diagram.png" style="width:434px;height:354px;" alt="Scopes"></center>


!SLIDE small
# Variable Example (1/2)

    @@@Puppet
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

    @@@Puppet
    ...
      service { 'httpd':
        ensure    => running,
        enable    => true,
        name      => $service,
        subscribe => File[$config],
      }
    }


    class apache::params {
      case $::os['family'] {
        'RedHat': {
          $package = 'httpd'
          $config  = '/etc/httpd/conf/httpd.conf'
          $service = 'httpd'
        }
        default: {
          fail('Your plattform is not supported, yet.')
        }
      }
    }
