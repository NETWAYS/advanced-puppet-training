!SLIDE smbullets small
# Modules and Classes

<pre>
class apache {
  package { 'httpd':
    ensure => installed,
  }

  file { '/etc/httpd/conf/httpd.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/apache/httpd.conf',
  }

  service { 'httpd':
    ensure => running,
    enable => true,
  }
}
</pre>
