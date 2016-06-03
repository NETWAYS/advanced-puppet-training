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

    @@@ Sh
    # cat /etc/yum.conf
    [main]
    cachedir=/var/cache/yum/$basearch/$releasever
    keepcache=0

    # augtool
    augtool> ls /files/etc/yum.conf/main
    cachedir = /var/cache/yum/$basearch/$releasever
    keepcache = 0
    ...


!SLIDE small
# augeas Usage

Example usage:

    @@@ Puppet
    augeas { "yum_config":
      context => "/files/etc/yum.conf/main",
      changes => [
        "set keepcache 1",
      ],
    }

Help:

    @@@ Sh
    # puppet describe augeas


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use augeas

* Objective:
 * Use `augeas` to modify `/etc/ssh/sshd_config`
* Steps:
 * Install package `augeas`
 * Use `augtool` to list `/etc/ssh/sshd_config`
 * Create a new module called `ssh`
 * Create a new subclass called `augeas`
 * Make sure that `X11Forwarding` is set to `no` using augeas
 * Add a smoke test and apply your manifest 


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use augeas

## Objective:

****

* Use `augeas` to modify `/etc/ssh/sshd_config`

## Steps:

****

* Install package `augeas`
* Use `augtool` to list `/etc/ssh/sshd_config`
* Create a new module called `ssh`
* Create a new subclass called `augeas`
* Make sure that `X11Forwarding` is set to `no` using augeas
* Add a smoke test and apply your manifest


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use augeas

****

    @@@ Sh
    # yum install augeas
    # augtool
    augtool> ls /files/etc/ssh/sshd_config
    ...
    X11Forwarding = yes
    ...


    @@@ Puppet
    # mkdir -p /etc/puppet/modules/ssh/{manifests,examples}
    # vim /etc/puppet/modules/ssh/manifests/augeas.pp
    class ssh::augeas {
      augeas { "sshd_config":
        context => "/files/etc/ssh/sshd_config",
        changes => [
          "set X11Forwarding no",
        ],
      }

   # vim /etc/puppet/modules/ssh/examples/augeas.pp
   include ssh::augeas

   # puppet apply --noop /etc/puppet/modules/ssh/examples/augeas.pp
   # puppet apply /etc/puppet/modules/ssh/examples/augeas.pp
