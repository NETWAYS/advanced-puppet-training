!SLIDE smbullets small
# Templates

<pre>
$servername = $::fqdn

file { $config:
  ensure => file,
  owner  => 'root',
  group  => 'root',
  content => template('apache/httpd.conf.erb'),
}
</pre>

<pre>
# vim ~/puppetcode/modules/apache/templates/httpd.conf.erb
...
ServerName <%= @servername %>
...
</pre>
