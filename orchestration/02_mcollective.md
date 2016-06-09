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

    @@@ Sh
    # mco ping
    dev8                                     time=126.19 ms
    dev6                                     time=132.79 ms
    dev10                                    time=133.57 ms
    ...
    ---- ping statistics ----
    25 replies max: 305.58 min: 57.50 avg: 113.16

* Primary interaction is via commandline
* `mco` executable brokers your commands to application plugins
* `ping` is the application called by the `mco` executable
* `mco help` will generate a list of application plugin
