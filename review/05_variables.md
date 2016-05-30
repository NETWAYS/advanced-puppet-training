!SLIDE smbullets small
# Variables

<pre>
class apache {
  include apache::params

  $package = $apache::package
  $config  = $apache::config
  $service = $apache::service

  package { $package:
    ensure => installed,
  }

  file { $config:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source => '~/puppetcode/files/httpd.conf',
  }

  service { 'httpd':
    ensure    => running,
    enable    => true,
    name      => $service,
    subscribe => File[$config],
  }
}
<pre>

<pre>
class apache::params {
  $package = 'httpd'
  $config  = '/etc/httpd/conf/httpd.conf'
  $service = 'httpd'
}
</pre>
