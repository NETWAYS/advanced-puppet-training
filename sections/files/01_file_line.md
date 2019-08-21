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

    @@@Puppet
    file_line { 'bashrc_proxy':
      ensure => present,
      path   => '/etc/bashrc',
      line   => 'export HTTP_PROXY=http://proxy:8080',
      match  => '^export HTTP_PROXY=',
    }

Help:

    @@@Sh
    $ puppet describe file_line


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use file_line

* Objective:
 * Use the `file_line` resource type
* Steps:
 * Create a new module called `ssh`
 * Create a new subclass called `file_line`
 * Make sure that `GSSAPIAuthentication` is set to `no` using file_line
 * Add a smoke test and apply your manifest


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use file_line

## Objective:

****

* Use the `file_line` resource type

## Steps:

****

* Create a new module called `ssh`
* Create a new subclass called `file_line`
* Make sure that `GSSAPIAuthentication` is set to `no` using file_line
* Add a smoke test and apply your manifest


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use file_line 

****

    @@@Sh
    training@agent $ cd /home/training/puppet/modules
    training@agent $ pdk module generate ssh
    training@agent $ cd ssh
    training@agent $ pdk new class ssh
    training@agent $ pdk new class file_line

    training@agent $ vim manifests/file_line.pp
    class ssh::file_line {
      file_line { 'GSSAPIAuthentication':
        ensure => present,
        path   => '/etc/ssh/sshd_config',
        line   => 'GSSAPIAuthentication no',
        match  => '^GSSAPIAuthentication',
      }
    }

    training@agent $ puppet parser validate manifests/file_line.pp
    training@agent $ vim examples/file_line.pp
    include ssh::file_line

    training@agent $ puppet parser validate examples/file_line.pp
    training@agent $ sudo puppet apply --noop examples/file_line.pp
    training@agent $ sudo puppet apply examples/file_line.pp
