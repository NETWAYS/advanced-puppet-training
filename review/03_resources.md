!SLIDE smbullets small
# Resources

    @@@ Puppet
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

* Resources are building blocks
* They can be combined to make larger components
* Together they can model the expected state of your system


!SLIDE smbullets small
# Resource Relationships

    @@@ Puppet
    package { 'httpd':
      ensure => installed,
    }

    file { '/etc/httpd/conf/httpd.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      source => 'puppet:///modules/apache/httpd.conf',
      require => Package['httpd'],
    }

    service { 'httpd':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/httpd/conf/httpd.conf'],
    }

* Puppet does not enforce resources top down
* Four metaparameters to define relationships (before, subscribe, require and notify)


!SLIDE smbullets small noprint
# Implicit Dependencies

<center><img src="../_images/review/implicit_dependencies.png" style="width:800px;height:492px;" alt="Implicit Dependencies"></center>


!SLIDE smbullets small printonly
# Implicit Dependencies

<center><img src="../_images/review/implicit_dependencies.png" style="width:480px;height:295px;" alt="Implicit Dependencies"></center>

~~~SECTION:handouts~~~

****

The picture above shows an overview of the most important implicit dependencies.
A dependency is only created if both resources are managed by Puppet.

Two more detailed examples are shown on the next sides. To find all implicit dependencies
have a look on the Autorequires description of the resources on:
https://docs.puppet.com/puppet/latest/reference/type.html

~~~ENDSECTION~~~


!SLIDE noprint
# Resource Abstraction Layer

<center><img src="../_images/review/resource_abstraction_layer.png" style="width:702px;height:460px;" alt="Resource Abstraction Layer"></center>


!SLIDE printonly
# Resource Abstraction Layer

<center><img src="../_images/review/resource_abstraction_layer.png" style="width:480px;height:315px;" alt="Resource Abstraction Layer"></center>


!SLIDE smbullets small
# Puppet Resource Command

    @@@ Puppet
    # puppet resource package vim-enhanced
    package { 'vim-enhanced':
      ensure => 'purged',
    }

    # puppet resource package vim-enhanced ensure=present
    Notice: /Package[vim-enhanced]/ensure: created
    package { 'vim-enhanced':
      ensure => '7.4.160-1.el7',
    }

* Puppet provides a command to directly interact with the Resource Abstraction Layer
* Querying all or one resource of a type returns Puppet code representation of current state
* Setting attributes will change state using available provider
