!SLIDE small
# Inventory

    @@@Sh
    $ mco inventory puppet.localdomain
    Inventory for puppet.localdomain:

    Server Statistics:
                     Version: 2.8.9
                  Start Time: 2016-08-11 10:53:53 +0200
                 Config File: /etc/puppetlabs/mcollective/server.cfg
                 Collectives: mcollective
             Main Collective: mcollective
                  Process ID: 8181
              Total Messages: 8
     Messages Passed Filters: 8
           Messages Filtered: 0
            Expired Messages: 0
                Replies Sent: 7
        Total Processor Time: 1.42 seconds
                 System Time: 2.68 seconds

    Agents:
      discovery       rpcutil

    ...


!SLIDE small
# Filtering Nodes

    @@@Sh
    $ mco ping --with-fact osfamily=RedHat
    master.example.com                     time=135.94 ms
    agent.example.com                      time=136.55 ms
    ---- ping statistics ----
    2 replies max: 136.55 min: 135.94 avg: 136.25

* Perform actions on a subset of your infrastructure
* Filter based on rich metadata, not complex hostname rules:
 * Facter facts (`--with-fact` or `-F`)
 * Puppet classes (`--with-class` or `-C`)
 * more...
* Filters are case sensitive and support regular expressions


!SLIDE small
# Help Subsystem for Applications

    @@@Sh
    $ mco rpc --help

    Generic RPC agent client application

    Usage: mco rpc [options] [filters] --agent <agent> \
      --action <action> [--argument <key=val> --argument ...]
    Usage: mco rpc [options] [filters] <agent> <action> \
      [<key=val> <key=val> ...]

    Application Options
            --no-results, --nr           Do not process results...
        -a, --agent AGENT                Agent to call
            --action ACTION              Action to call
            --arg, --argument ARGUMENT   Arguments to pass to agent
    ...

* `mco help:` List applications available on a system
* `mco <application> --help:` Display application documentation


!SLIDE small
# Help Subsystem for Agents

    @@@Sh
    $ mco help service
    Service Agent
    =============

    Start and stop system services

          Author: R.I.Pienaar
         Version: 1.2
         License: ASL2
         Timeout: 60
       Home Page: https://github.com/puppetlabs/mcollective-plugins

    ACTIONS:
    ========
       restart, start, status, stop
    ...

Display agent documentation:

    @@@Sh
    $ mco help <agent>
