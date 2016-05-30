!SLIDE smbullets small
# Conditions

<pre>
class apache::params {
  case $::osfamily {
    'RedHat': {
      $package = 'httpd'
      $config  = '/etc/httpd/conf/httpd.conf'
      $service = 'httpd'
    }
    'Debian': {
      $package = 'apache2'
      $config  = '/etc/apache2/apache2.conf'
      $service = 'apache2'
    }
  }
}
</pre>
