!SLIDE smbullets small
# Defined Resources

<pre>
define apache::vhost(
  Enum['present','absent'] $ensure    = present,
  String                   $vhostname = $title,
  String                   $docroot   = undef,
) {
  include apache::params

  if $docroot {
    $vhost_docroot = $docroot
  } else
    $vhost_docroot = "${apache_vhostdir}/${vhostname}.conf"
  }

  file { "${apache_vhostd}/${vhostname}.conf":
    ensure  => file,
    content => template('apache/vhost.conf.erb'),
    notify  => Service['httpd'],
  }
}
</pre>

<pre>
<VirtualHost *:80>
    DocumentRoot "<%= @vhost_docroot %>"
    ServerName <%= @vhostname %>
</VirtualHost>
</pre>
