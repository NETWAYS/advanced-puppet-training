!SLIDE subsectionnonum
# augeas

!SLIDE smbullets
# augeas Overview

* Treats files as trees of values
* Modify the tree as you like and write them back
* Uses `augtool`
* File parsing based on lenses
* Built-in resource type


!SLIDE small
# augtool Usage

    @@@Sh
    $ cat /etc/yum.conf
    [main]
    cachedir=/var/cache/yum/$basearch/$releasever
    keepcache=0
    ...

    $ augtool
    augtool> ls /files/etc/yum.conf/main
    cachedir = /var/cache/yum/$basearch/$releasever
    keepcache = 0
    ...


!SLIDE small
# augeas Usage

Example usage:

    @@@Puppet
    augeas { 'yum_config':
      context => '/files/etc/yum.conf/main',
      changes => [
        'set keepcache 1',
      ],
    }

Help:

    @@@Sh
    $ puppet describe augeas


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use augeas

* Objective:
 * Use `augeas` to modify `/etc/ssh/sshd_config`
* Steps:
 * Install package `augeas`
 * Use `augtool` to list `/etc/ssh/sshd_config`
 * Create a new subclass called `augeas`
 * Make sure that `X11Forwarding` is set to `no` using augeas
 * Add a smoke test and apply your manifest 
* Bonus:
 * Add a smoke test using your both subclasses and apply it


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use augeas

## Objective:

****

* Use `augeas` to modify `/etc/ssh/sshd_config`

## Steps:

****

* Install package `augeas`
* Use `augtool` to list `/etc/ssh/sshd_config`
* Create a new subclass called `augeas`
* Make sure that `X11Forwarding` is set to `no` using augeas
* Add a smoke test and apply your manifest

### Bonus:

* Add a smoke test using your both subclasses and apply it


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use augeas

****

    @@@Sh
    training@agent $ sudo yum install augeas
    training@agent $ sudo augtool
    augtool> ls /files/etc/ssh/sshd_config
    ...
    X11Forwarding = yes
    ...

    training@agent $ cd /home/training/puppet/modules/ssh
    training@agent $ pdk new class augeas
    training@agent $ vim manifests/augeas.pp
    class ssh::augeas {
      augeas { 'sshd_config':
        context => '/files/etc/ssh/sshd_config',
        changes => [
          'set X11Forwarding no',
        ],
      }
    }

    training@agent $ puppet parser validate manifests/augeas.pp
    training@agent $ vim examples/augeas.pp
    include ssh::augeas

    training@agent $ puppet parser validate examples/augeas.pp 
    training@agent $ sudo puppet apply --noop examples/augeas.pp
    training@agent $ sudo puppet apply examples/augeas.pp

## Bonus

    @@@Sh
    training@agent $ cd /home/training/puppet/modules/ssh
    training@agent $ vim examples/filechanges.pp
    include ssh::file_line
    include ssh::augeas

    training@agent $ puppet parser validate examples/filechanges.pp
    training@agent $ sudo puppet apply --noop examples/filechanges.pp
    training@agent $ sudo puppet apply examples/filechanges.pp
