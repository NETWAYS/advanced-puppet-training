!SLIDE small
# ERB Templates

Manifest:

    @@@ Puppet
    $servername = $::fqdn

    file { $config:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      content => template('apache/httpd.conf.erb'),
    }

Embedded Ruby Template:

    # vim /etc/puppet/modules/apache/templates/httpd.conf.erb
    ...
    ServerName <%= @servername %>
    ...


!SLIDE small
# EPP Templates

Manifest:

    @@@ Puppet
    $servername = $::fqdn

    file { $config:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      content => epp('apache/httpd.conf.epp'),
    }

Embedded Puppet Template:

    # vim /etc/puppet/modules/apache/templates/httpd.conf.epp
    ...
    ServerName <%= $servername %>
    ...
