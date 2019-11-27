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

    @@@ Puppet
    $ vim apache/templates/httpd.conf.erb
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
      content => epp('apache/httpd.conf.epp',
                     { servername => $servername }),
    }

Embedded Puppet Template:

    @@@ Puppet
    $ vim apache/templates/httpd.conf.epp
    <%- | String $servername = "localhost" | -%>
    ...
    ServerName <%= $servername %>
    ...

!SLIDE small
# Code in templates

Embedded Ruby Template:

    @@@ Puppet
    $ vim apache/templates/httpd.conf.erb
    ...
    <% if @servername != nil %>
    ServerName <%= @servername %>
    <% else %>
    ServerName "not-defined"
    <% end %>    
    ...

Embedded Puppet Template:

    @@@ Puppet
    <% if $servername != undef { -%>
    ServerName <%= $servername %>
    <% } else { -%>
    ServerName "not-defined"
    <% } -%>

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

The Embedded Puppet Template language is unique to puppet while Embedded Ruby is a syntax shared with other projects.
Embedded Puppet requires you to explicitly provide variables to the template as a parameter hash, but adds the possible
to set defaults to and valid parameter simply with inclusion of a header in the template file. In other ways both are very
similar but Embedded Puppet is more Puppet than Ruby-like.

~~~ENDSECTION~~~
