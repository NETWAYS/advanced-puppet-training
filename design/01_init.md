!SLIDE smbullets small
# Good Module Design

* only manage their own resources.
 * Don't manage logrotating in your apache module.
 * What happens if your drupal module manage Apache and PHP?
* be granular, portable and reusable.
* avoid exposing implementation details.

!SLIDE smbullets small
# Architecting Modules

## Motivation

* Huge applications to manage, such as Apache or Tomcat
* A lot of code lines
* Complex dependency structures
* Some examples:
 * puppetlbas/apache
 * camptocamp/tomcat

!SLIDE smbullets small
# Main Class

* Split off your class in subclasses.
* Define dependencies between these classes.

<pre>
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
</pre>

!SLIDE smbullets small
# Subclass params

* Used for develop plattform independency modules.
* Set default values for parameters in the main class.
* Inherits variable scope to all child classes.
* Dependencies between resources will be defined only between resources contain to the same subclass.

<pre>
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
</pre>

!SLIDE smbullets small
# Subclass install

* Class to do all stuff of the installation.
* Contains all resources that don't enforce a service restart if they changed.

<pre>
class custom::install inherits custom::params {
  package { $custom_package:
    ensure => installed,
  }
}
</pre>

!SLIDE smbullets small
# Subclass config

* Class with all resources that enforce a restart of the service if they changed.

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

* Finally the service subclass handles all resources to manage the service respectively services.

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

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Module Design

* Objective:
 * Rework the apache module using the described method.
* Steps:
 * Copy init.pp to install.pp, config.pp and service.pp.
 * Rework every of this four files.
 * Don't forget to modify the vhost define resource too.
 * Run all the smoke tests again.

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Module Design

## Objective:

****

* Rework the apache module using module design guidlines

## Steps:

****

* Copy init.pp to install.pp, config.pp and service.pp.
* Rework every of this four files.
* Don't forget to modify the vhost define resource too.
* Run all the smoke tests again.

#### Expected Result:

The same should be happend as before reworked the module.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Module Design

****

## Rework the apache module using module design guidelines

****

### Rework the main class apache

<pre>
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
</pre>

### Review the class apache::params

<pre>
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
</pre>

### Create the class apache::install

<pre>
class apache::install inherits apache::params {
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
</pre>

### Create the class apache::config

<pre>
class apache::config inherits apache::params {
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
</pre>

### Create the class apache::service

<pre>
class apache::service inherits apache::params {

  $ensure = $apache::ensure
  $enable = $apache::enable

  service { $apache_service:
    ensure => $ensure,
    enable => $enable,
  }
}
</pre>

### Modify the define resource apache::vhost

<pre>
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
</pre>


!SLIDE smbullets small
# The Containment Problem

* Classes contain all of the resources included.
 * Relationships to the class transfer to included resources.
 * Relationships do NOT transfer to included classes
* Enforcement order can be unpredictable and surprising.
* Classes included in other classes are unordered.

<pre>
class repo {
  yumrepo { 'custom':
    ...
  }
}

class apache {
  include apache::install
  include apache::config
  include apache::service
}

Class['repo'] -> Class['apache']
</pre>


!SLIDE smbullets small
# The Containment Problem

****

## Classes aren't contained.

****

### Where ist host::secure contained?

<pre>
class repo {
  include host::secure

  yumrepo { 'custom':
    ...
  }
}

class apache {
  include host::secure

  include apache::install
  include apache::config
  include apache::service
}

Class['repo'] -> Class['apache']
</pre>


!SLIDE smbullets small
# Anchor Pattern

* Resources are contained.
* Relationshipe can be defined between resources and classes.
* use anchor resources to manually bookend classes.

<pre>
class apache {
  anchor { 'apache::begin': }
    -> Class['apache::install']
    -> Class['apache::config']
    ~> Class['apache::service']
    -> anchor { 'apache::end': }

  include apache::install
  include apache::config
  include apache::service
}

class { 'repo':
  before => Class['apache']
}
</pre>

### You can use also the function contain instead of include since Puppet 3.4, contain automates the anchor pattern.
