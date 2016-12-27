!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add Orchestration

* Objective:
 * Add orchestration with MCollective using ActiveMQ
* Steps:
 * Install and start ActiveMQ
 * Configure MCollective to work with ActiveMQ
 * Start MCollective Server
 * Test orchestration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add Orchestration

## Objective:

****

* Add orchestration with MCollective using ActiveMQ

## Steps:

****

* Install and start ActiveMQ on your puppet master

You can get it from a community repository: https://copr.fedoraproject.org/coprs/lkiesow/apache-activemq-dist/repo/epel-7/lkiesow-apache-activemq-dist-epel-7.repo

* Configure MCollective to work with ActiveMQ
* Start MCollective Server
* Test orchestration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add Orchestration

****

Install ActiveMQ from a third party repository:

    @@@Sh
    $ sudo curl -L https://copr.fedoraproject.org \
      /coprs/lkiesow/apache-activemq-dist/repo/epel-7/lkiesow-apache-activemq-dist-epel-7.repo \
      -o /etc/yum.repos.d/lkiesow-apache-activemq-dist-epel-7.repo
    $ sudo yum install activemq-dist

Configure and start ActiveMQ:

    @@@Sh
    $ sudo vim /etc/activemq/activemq.xml
    ...
    <transportConnectors>
      <transportConnector name="stomp" uri= \
        "stomp://0.0.0.0:61613?maximumConnections=1000&amp;wireFormat.maxFrameSize=104857600" \
      />
    </transportConnectors>
    ...

    $ sudo systemctl start activemq.service
    $ sudo systemctl enable activemq.service

Configure MCollective to work with ActiveMQ:

You do not need to install MCollective as a seperate package because it is already included in Puppet's all-in-one-package.
You only have to configure it to find your message queue (host and port).

    @@@Sh
    $ sudo vim /etc/puppetlabs/mcollective/server.cfg
    ...
    connector = activemq
    plugin.activemq.pool.size = 1
    plugin.activemq.pool.1.host = localhost
    plugin.activemq.pool.1.port = 61613
    plugin.activemq.pool.1.user = mcollective
    plugin.activemq.pool.1.password = marionette
    ...

    $ sudo vim /etc/puppetlabs/mcollective/client.cfg
    ...
    connector = activemq
    plugin.activemq.pool.size = 1
    plugin.activemq.pool.1.host = localhost
    plugin.activemq.pool.1.port = 61613
    plugin.activemq.pool.1.user = mcollective
    plugin.activemq.pool.1.password = marionette
    ...

If you want to test MCollective with your puppet agent machine too, configure and start the mcollective server on this machine and use the IP address or fqdn instead of localhost.

Start MCollective Server:

    @@@ Sh
    $ sudo systemctl start mcollective.service
    $ sudo systemctl enable mcollective.service

Test orchestration on a machine:

    @@@ Sh
    $ mco ping
    agent-centos.localdomain      time=41.53 ms
    puppet.localdomain            time=75.71 ms

In a productive environment you should not run a message queue without securing it! In this configuration it only uses a password on a clear-text connection.
