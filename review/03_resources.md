!SLIDE smbullets small
# Resources

<pre>
package { 'httpd':
  ensure => installed,
}

file { '/etc/httpd/conf/httpd.conf':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  source => '~/puppetcode/files/httpd.conf',
}

service { 'httpd':
  ensure => running,
  enable => true,
}
</pre>

!SLIDE smbullets small
# Resource Relationships

<pre>
package { 'httpd':
  ensure => installed,
}

file { '/etc/httpd/conf/httpd.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  source  => '~/puppetcode/files/httpd.conf',
  require => Package['httpd'],
}

service { 'httpd':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/httpd/conf/httpd.conf'],
}
</pre>
