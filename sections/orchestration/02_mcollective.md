!SLIDE smbullets
# MCollective Middleware

* Uses message oriented middleware to broker messages between nodes
 * Messages are sent on communications channels called topics
 * Agents on each node subscribe to topics and respond to requests
 * Master node issues actions by publishing messages to the queue
* Middleware Connectors:
 * ActiveMQ
 * RabbitMQ


!SLIDE small
# Using MCollective

    @@@Sh
    $ mco ping
    agent-centos.localdomain                 time=38.53 ms
    puppet.localdomain                       time=75.71 ms
    ...
    ---- ping statistics ----
    2 replies max: 75.71 min: 38.53 avg: 57.12

* Primary interaction is via commandline
* `mco` executable brokers your commands to application plugins
* `ping` is the application called by the `mco` executable
* `mco help` will generate a list of application plugin
