!SLIDE small
# Audit Metaparameter

    @@@Puppet
    file { '/etc/hosts':
      audit => [ owner, group, mode ],
    }

* Normally Puppet resources describe desired state
* `audit` metaparameter instructs Puppet to monitor
* Provide a list of attributes to monitor:
 * `all` instructs Puppet to monitor all attributes
* Puppet will inform you when changes occur
* Can monitor any resource

~~~SECTION:notes~~~

Tell the student that you can manage and audit an attribute, but it will result in
an additional audit event after Puppet reverted the drift.

~~~ENDSECTION~~~


!SLIDE small
# Using Audit Metaparameter

    @@@Puppet
    file { '/etc/motd':
      ensure  => present,
      audit   => all,
    }

    $ sudo puppet apply audit.pp
    notice: File[/etc/motd]/ensure: audit change: newly-recorded ...
    notice: File[/etc/motd]/content: audit change: newly-recorded ...
    notice: File[/etc/motd]/owner: audit change: newly-recorded ...
    notice: File[/etc/motd]/group: audit change: newly-recorded ...
    notice: File[/etc/motd]/mode: audit change: newly-recorded ...
    [...]
    notice: Finished catalog run in 0.02 seconds


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Auditing

* Objective:
 * Use Puppet for auditing on `agent-centos.localdomain`
* Steps:
 * Audit all attributes of `/etc/ssh/sshd_config`
 * Manage owner, group and mode and audit its content of `/etc/resolv.conf`
 * Apply this manifest to record the value
 * Change the content of both files
 * Apply the manifest to get audit changes
 * Change the mode of both files to `0666`
 * Apply the manifest to get audit changes 


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Auditing

## Objective:

****

* Use Puppet for auditing on `agent-centos.localdomain`

## Steps:

****

* Audit all attributes of `/etc/ssh/sshd_config`
* Manage owner, group and mode and audit its content of `/etc/resolv.conf`
* Apply this manifest to record the value
* Change the content of both files
* Apply the manifest to get audit changes
* Change the mode of both files to `0666`
* Apply the manifest to get audit changes 


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Auditing

****


Audit all attributes of `/etc/ssh/sshd_config` and manage owner, group and mode and audit its content of `/etc/resolv.conf`:

    @@@Sh
    $ vim audit.pp
    file { '/etc/ssh/sshd_config':
      audit => all,
    }

    file { '/etc/resolv.conf':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      audit  => content,
    }

    $ puppet parser validate audit.pp

Apply this manifest to record the value:

During this apply you should see messages including `audit change: newly-recorded value`.

    @@@Sh
    $ sudo puppet apply audit.pp

Change the content of both files:

    @@@Sh
    # echo "# content change" >> /etc/ssh/sshd_config
    # echo "# content change" >> /etc/resolv.conf

Apply the manifest to get audit changes:

During this apply you should see messages containing `audit change: previously recorded value ... has been changed`

    @@@Sh
    $ sudo puppet apply audit.pp

Change the mode of both files to `0666`:

    @@@Sh
    $ sudo chmod 0666 /etc/ssh/sshd_config
    $ sudo chmod 0666 /etc/resolv.conf

Apply the manifest to get audit changes :

During this apply you should see message about `audit change` for `sshd_config` and `mode change` on `resolv.conf`

    @@@Sh
    $ sudo puppet apply audit.pp
