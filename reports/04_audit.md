!SLIDE small
# Audit Metaparameter

    @@@ Puppet
    file { '/etc/hosts':
      audit => [ owner, group, mode ],
    }

* Normally Puppet resources describe desired state
* `audit` metaparameter instructs Puppet to monitor
* Provide a list of attributes to monitor:
 * `all` instructs Puppet to monitor all attributes
* Puppet will inform you when changes occur
* Can monitor any resource


!SLIDE small
# Using Audit Metaparameter

    @@@ Puppet
    file { '/etc/motd':
      ensure  => present,
      audit   => all,
    }

<pre>
# puppet apply audit.pp
notice: /Stage[main]//File[/etc/motd]/ensure: audit change: newly-recorded v...
notice: /Stage[main]//File[/etc/motd]/content: audit change: newly-recorded ...
notice: /Stage[main]//File[/etc/motd]/owner: audit change: newly-recorded va...
notice: /Stage[main]//File[/etc/motd]/group: audit change: newly-recorded va...
notice: /Stage[main]//File[/etc/motd]/mode: audit change: newly-recorded val...
[...]
notice: Finished catalog run in 0.02 seconds
# echo "** Externally Modified **" >> /etc/motd
# puppet apply audit.pp
notice: /Stage[main]//File[/etc/motd]/content: audit change: previously reco...
notice: /Stage[main]//File[/etc/motd]/ctime: audit change: previously record...
notice: /Stage[main]//File[/etc/motd]/mtime: audit change: previously record...
notice: Finished catalog run in 0.02 seconds
# cat /etc/motd
This is managed by Puppet
** Externally Modified **
</pre>


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Report Processors

* Objective:
 * Use Report Processors
* Steps:
 * Step 1
 * Step 2


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Report Processors

## Objective:

****

* Use Report Processors

## Steps:

****

* Step 1
* Step 2


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Report Processors

****

Some solution:

    @@@ Sh
    # ...
