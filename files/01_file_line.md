!SLIDE subsectionnonum
# file_line

!SLIDE smbullets
# file_line Overview 

* Ensures that a given line is contained within a file
* Custom resource type
* Included in puppetlabs/stdlib module since 2.1


!SLIDE small
# file_line Usage

Example usage:

    @@@ Puppet
    file_line { 'bashrc_proxy':
      ensure => present,
      path   => '/etc/bashrc',
      line   => 'export HTTP_PROXY=http://proxy:8080',
      match  => '^export\ HTTP_PROXY\=',
    }

Help:

    @@@ Sh
    # puppet describe file_line


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use file_line

* Objective:
 * Use the `file_line` resource type
* Steps:
 * Install module `puppetlabs-stdlib`
 * Create a new module called `apache`
 * Manage package `httpd`
 * Manage file `/var/www/html/index.html`
 * Make sure that the Indexpage contains `<h1>Welcome to the training!</h1>` using `file_line`
 * Add a smoke test and apply your manifest


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use file_line

## Objective:

****

* Use the `file_line` resource type

## Steps:

****

* Install module `puppetlabs-stdlib`
* Create a new module called `apache`
* Manage package `httpd`
* Manage file `/var/www/html/index.html`
* Make sure that the Indexpage contains `<h1>Welcome to the training!</h1>` using `file_line`
* Add a smoke test and apply your manifest


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use file_line 

****

    @@@ Sh
    # puppet module install puppetlabs-stdlib
    # mkdir -p /etc/puppet/modules/apache/{manifests,examples}

    @@@ Vim
    # vim /etc/puppet/modules/apache/manifests/init.pp
    class apache {
      package { 'httpd':
        ensure => present,
      }

      file { '/var/www/html/index.html':
        ensure => file,
        owner  => 'root',
        group  => 'root',
      }

      file_line { 'Indexpage':
        ensure => present,
        path   => '/var/www/html/index.html',
        line   => '<h1>Welcome to the training!</h1>',
      }
    }

    # vim /etc/puppet/modules/apache/examples/init.pp
    include apache

    @@@ Sh
    # puppet apply --noop /etc/puppet/modules/apache/examples/init.pp
    # puppet apply /etc/puppet/modules/apache/examples/init.pp
