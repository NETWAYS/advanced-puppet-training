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
 * Use `tagmail` Report Processor
* Steps:
 * Install `puppetlabs-tagmail` module
 * Ensure that `report` and `pluginsync` are enabled
 * Configure `tagmail` report processor in `puppet.conf`
 * Create `tagmail.conf` using sendmail
 * Send emails with tag `webserver` to `root@localhost`
 * Set tag `webserver` for `apache` main class
 * Apply and validate your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Report Processors

## Objective:

****

* Use `tagmail` Report Processor

## Steps:

****

* Install `puppetlabs-tagmail` module
* Ensure that `report` and `pluginsync` are enabled
* Configure `tagmail` report processor in `puppet.conf`
* Create `tagmail.conf` using sendmail
* Send emails with tag `webserver` to `root@localhost`
* Set tag `webserver` for `apache` main class
* Apply and validate your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Report Processors

****

Install `puppetlabs-tagmail` module:

    @@@ Sh
    # puppet module install puppetlabs-tagmail

Ensure that `report` and `pluginsync` are enabled:

    @@@ Sh
    # puppet config print report
    true
    # puppet config print pluginsync
    true

Configure `tagmail` report processor in `puppet.conf`:

    @@@ Sh
    # vim /etc/puppet/puppet.conf
    [master]
      #reports = store
      #reportdir = /var/lib/puppet/reports
      reports = tagmail

Send emails with tag `webserver` to `root@localhost`:

    @@@ Sh
    # vim /etc/puppet/tagmail.conf
    [transport]
    reportfrom = puppetmaster@training.vm
    sendmail = /usr/sbin/sendmail

    [tagmap]
    webserver: root@localhost

Set tag `webserver` for `apache` main class

    @@@ Sh
    # vim /usr/local/src/apache/examples/init.pp
    class { 'apache':
      tag => 'webserver',
    }

Apply and validate your configuration:

    @@@ Sh
    # puppet apply /usr/local/src/apache/examples/init.pp
    # vim /var/mail/root
