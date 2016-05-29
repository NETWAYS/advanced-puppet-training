!SLIDE smbullets small
# file_line Resource

****

Included in puppetlabs/stdlib module since 3.0

****

<pre>
file_line { 'bashrc_proxy':
  ensure => present,
  path   => '/etc/bashrc',
  line   => 'export HTTP_PROXY=http://proxy:8080',
  match  => 'export /HTTP_PROXY=/',
}
</pre>

