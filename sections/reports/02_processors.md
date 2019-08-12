!SLIDE small
# Configuring Report Processors

On the Puppet Agent:

    @@@Sh
    $ sudo vim /etc/puppetlabs/puppet/puppet.conf
    [agent]
        report = true

On the Puppet Master:

    @@@Sh
    $ sudo vim /etc/puppetlabs/puppet/puppet.conf
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

    @@@Puppet
    $ tail -f /var/log/puppetlabs/puppet/masterhttp.log
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
 * Enable the `store` Core Report Processor on `puppet.localdomain`
* Steps:
 * Configure `store` report processor in `puppet.conf`
 * Set `reportdir` to `/var/lib/puppet/reports`
 * Restart Puppet Master
 * Have a look at the generated reports


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Core Report Processors

## Objective:

****

* Enable the `store` Core Report Processor on `puppet.localdomain`

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

    @@@Sh
    $ sudo vim /etc/puppetlabs/puppet/puppet.conf
    [master]
      reports = puppetdb,store
      reportdir = /var/lib/puppet/reports

Restart Puppet Master:

    @@@Sh
    $ sudo systemctl restart puppetmaster

Have a look at the generated reports:

    @@@Sh
    $ ls /var/lib/puppet/reports/


!SLIDE small
# Module Provided Report Processors

    @@@Sh
    $ puppet module search report
    Notice: Searching https://forgeapi.puppetlabs.com ...
    NAME                            DESCRIPTION
    evenup-logstash_reporter        Report processor...
    evenup-graphite_reporter        Report processor...
    danzilio-report_all_the_things  Dumps the complete...
    danzilio-scribe_reporter        A report processor...

* Integrate with external reporting solutions

<pre>
$ puppet module install jamtur01/irc
...
$ tree /home/training/puppet/modules/irc/lib/
/home/training/puppet/modules/irc/lib/
└── puppet
    └── reports
        └── irc.rb
</pre>

* Installed and pluginsynced as part of a module


!SLIDE small
# tag Metaparameter

    @@@Puppet
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
$ sudo vim /etc/puppetlabs/puppet/tagmail.conf
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


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Report Processors

* Objective:
 * Use `tagmail` Report Processor on `puppet.localdomain`
* Steps:
 * Add `puppetlabs-tagmail` module to Puppetfile
 * Ensure that `report` and `pluginsync` are enabled
 * Configure `tagmail` report processor in `puppet.conf`
 * Create `tagmail.conf` using sendmail
 * Send emails with tag `webserver` to `root@localhost`
 * Set tag `webserver` for `apache` main class
 * Push and deploy your configuration
 * Remove the `httpd` package and trigger a Puppet run on `agent-centos.localdomain`:
 * Have a look at the mail on the Puppet Master


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Report Processors

## Objective:

****

* Use `tagmail` Report Processor on `puppet.localdomain`

## Steps:

****

* Add `puppetlabs-tagmail` module to Puppetfile
* Ensure that `report` and `pluginsync` are enabled
* Configure `tagmail` report processor in `puppet.conf`
* Create `tagmail.conf` using sendmail
* Send emails with tag `webserver` to `root@localhost`
* Set tag `webserver` for `apache` main class
* Push and deploy your configuration
* Remove the `httpd` package and trigger a Puppet run on `agent-centos.localdomain`
* Have a look at the mail on the Puppet Master


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Report Processors

****

Add `puppetlabs-tagmail` module to Puppetfile:

    @@@Sh
    $ cd /home/training/puppet
    $ vim Puppetfile
    module "puppetlabs/tagmail", :latest

Ensure that `report` and `pluginsync` are enabled:

    @@@Sh
    $ sudo puppet config print report
    true
    $ sudo puppet config print pluginsync
    true

Configure `tagmail` report processor in `puppet.conf`:

    @@@Sh
    $ sudo vim /etc/puppetlabs/puppet/puppet.conf
    [master]
      reports = puppetdb,store,tagmail
      reportdir = /var/lib/puppet/reports

Send emails with tag `webserver` to `root@localhost`:

    @@@Sh
    $ sudo vim /etc/puppetlabs/puppet/tagmail.conf
    [transport]
    reportfrom = puppetmaster@puppet.localdomain
    sendmail = /sbin/sendmail

    [tagmap]
    webserver: root@localhost

    $ sudo systemctl restart puppetmaster.service

Set tag `webserver` for `apache` main class

    @@@Sh
    $ cd /home/training/puppet
    $ vim manifests/site.pp
    node "agent-centos.localdomain" {
      #include apache
      class { 'apache':
        ssl => true,
        tag => 'webserver',
      }
    ...

Push and deploy your configuration:

    @@@Sh
    $ cd /home/training/puppet
    $ git add Puppetfile
    $ git add manifests/site.pp 
    $ git commit -m 'tagmail'
    $ git push origin production
    $ sudo puppet agent -t
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yml 

Remove the `httpd` package and trigger a Puppet run on `agent-centos.localdomain`:

    @@@Sh
    $ sudo yum remove httpd
    $ sudo puppet agent -t

Have a look at the mails on `puppet.localdomain`:

    $ sudo vim /var/spool/mail/root
