!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add Orchestration

* Objective:
 * Add orchestration with MCollective using ActiveMQ
* Steps:
 * Install latest Java OpenJDK
 * Install and start ActiveMQ
 * Install MCollective Server and Client tools
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

* Install latest Java OpenJDK
* Install and start ActiveMQ
* Install MCollective Server and Client tools
* Configure MCollective to work with ActiveMQ
* Start MCollective Server
* Test orchestration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add Orchestration

****

Install latest Java OpenJDK:

    @@@ Sh
    # yum install java-1.8.0-openjdk

Install and start ActiveMQ:

    @@@ Sh
    # yum install activemq
    # systemctl start activemq.service

Install MCollective Server and Client tools:

    @@@ Sh
    # yum install mcollective mcollective-client

Configure MCollective to work with ActiveMQ:

    @@@ Sh
    #vim /etc/mcollective/server.cfg
    ...
    connector = activemq
    plugin.activemq.pool.size = 1
    plugin.activemq.pool.1.host = localhost
    plugin.activemq.pool.1.port = 61613
    plugin.activemq.pool.1.user = mcollective
    plugin.activemq.pool.1.password = marionette
    ...

    #vim /etc/mcollective/client.cfg
    ...
    connector = activemq
    plugin.activemq.pool.size = 1
    plugin.activemq.pool.1.host = localhost
    plugin.activemq.pool.1.port = 61613
    plugin.activemq.pool.1.user = mcollective
    plugin.activemq.pool.1.password = marionette
    ...

Start MCollective Server:

    @@@ Sh
    # systemctl start mcollective.serve

Test orchestration:

    @@@ Sh
    # mco ping
