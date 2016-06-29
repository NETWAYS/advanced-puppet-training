!SLIDE small
# Configuring Report Processors

On the Puppet Agent:

    @@@ Sh
    # vim /etc/puppet/puppet.conf
    [agent]
        report = true

On the Puppet Master:

    @@@ Sh
    # vim /etc/puppet/puppet.conf
    [master]
        reports = https,tagmail,store,log
        reportdir = /var/lib/puppet/reports
        reporturl = http://localhost:3000/reports/upload


!SLIDE small
# store Report Processor

* Stores report data on the Puppet Master as YAML in the `reportdir` setting
* Available for external processing by custom tooling
* Default report processor
* Reports collect quickly, perform some maintenance on them:

    <pre>
    tidy { '/var/lib/puppet/reports':
      age     => '30d',
      matches => "*.yaml",
      recurse => true,
      rmdirs  => false,
      type    => ctime,
    }
    </pre>


!SLIDE smbullets
# http Report Processor

* Send reports via HTTP or HTTPS
* Submits reports as POST requests to the address in the `reporturl` setting
* Body is the YAML dump of a Puppet::Transaction::Report object
* Content-Type is set as `application/x-yaml`


!SLIDE small
# log Report Processor

    @@@ Puppet
    # tail -f /var/log/puppet/puppetserver/puppetserver.log
    Compiled catalog for training.puppetlabs.vm in 0.86 seconds
    Caching catalog for training.puppetlabs.vm
    Applying configuration version '1328977795'
    Hello World!
    (/Notify[example]/message) defined 'message' as 'Hello World!'
    Finished catalog run in 0.69 seconds

* Contains every log message in a transaction
* Can be used to centralize client logs into syslog
* Uses the system syslog calls


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Core Report Processors

* Objective:
 * Enable the `store` Core Report Processor
* Steps:
 * Configure `store` report processor in `puppet.conf`
 * Set `reportdir` to `/var/lib/puppet/reports`
 * Restart Puppet Master
 * Have a look at the generated reports


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Core Report Processors

## Objective:

****

* Enable the `store` Core Report Processor

## Steps:

****

* Configure `store` report processor in `puppet.conf`
* Set `reportdir` to `/var/lib/puppet/reports`
* Restart Puppet Master 
* Have a look at the generated reports


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Core Report Processors

****

Configure `store` report processor in `puppet.conf` and set `reportdir` to `/var/lib/puppet/reports`:

    @@@ Sh
    # vim /etc/puppet/puppet.conf
    [master]
      reports = store
      reportdir = /var/lib/puppet/reports

Restart Puppet Master:

    @@@ Sh
    # systemctl restart puppetserver

Have a look at the generated reports:

    @@@ Sh
    # ls /var/lib/puppet/reports/


!SLIDE small
# Module Provided Report Processors

    @@@ Sh
    # puppet module search report
    Notice: Searching https://forgeapi.puppetlabs.com ...
    NAME                            DESCRIPTION
    evenup-logstash_reporter        Report processor...
    evenup-graphite_reporter        Report processor...
    danzilio-report_all_the_things  Dumps the complete...
    danzilio-scribe_reporter        A report processor...

* Integrate with external reporting solutions

<pre>
# puppet module install jamtur01/irc
...
# tree /etc/puppet/modules/irc/lib/
/etc/puppet/modules/irc/lib/
└── puppet
    └── reports
        └── irc.rb
</pre>

* Installed and pluginsynced as part of a module


!SLIDE small
# tag Metaparameter

    @@@ Puppet
    apache::vhost {'docs.example.com':
      port => 80,
      tag  => ['us_mirror1', 'us_mirror2'],
    }

* Can be used with normal resources, defined resources and classes
* Every resource automatically receives the following tags: Resource type, full name of the class/defined type, every namespace segment of the resource’s class/defined type
* Used for:
 * Collecting resources (virtual and exported resources)
 * Restricting catalog runs
 * Sending `tagmail` reports
 * Reading tags in custom report handlers
 

!SLIDE small
# tagmail Report Processor

* Included in puppetlabs/tagmail module
* Delivers log reports via email based on tags
* Sends email when resources with matching tags change

Configuration:

<pre>
# vim /etc/puppet/tagmail.conf
[transport]
reportfrom = reports@example.org
smptserver = smtp.example.org
smtpport = 25
smtphelo = example.org

[tagmap]
all,!testing: admins@example.com
webserver,production: webadmin@example.com
security: secteam@example.com
</pre>
