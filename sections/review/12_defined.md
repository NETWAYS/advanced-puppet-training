!SLIDE small smbullets
# Defined Resource Type

    @@@ Puppet
    define apache::vhost(
      Enum['present','absent'] $ensure    = present,
      String                   $vhostname = $title,
      String                   $docroot   = undef,
    ) {
      include apache::params

      if $docroot {
        $vhost_docroot = $docroot
      } else {
        $vhost_docroot = "${apache_vhostdir}/${vhostname}"
      }
      file { "${apache_vhostdir}/${vhostname}.conf":
        ensure  => file,
        content => template('apache/vhost.conf.erb'),
        notify  => Service['httpd'],
      }
    }

* Very similar to parameterized classes
* But can be used multiple times
