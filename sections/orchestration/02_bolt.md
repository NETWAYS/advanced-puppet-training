!SLIDE smbullets
# Bolt

Bolt is meant to be installed on the master of your infrastructure.

* Use bolt to run commands remotely
* Upload a local file or directory to target nodes
* Install modules from a puppet file and more...

Further information on all the features puppet bolt has to offer at: https://puppet.com/docs/bolt/latest/bolt_command_reference.html

!SLIDE small
# Using Bolt

    @@@Sh
    $ bolt command run 'ping -c 4 8.8.8.8' --nodes agent-centos.localdomain
    Started on agent-centos.localdomain...
    Finished on agent-centos.localdomain:
      STDOUT:
        PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
        64 bytes from 8.8.8.8: icmp_seq=1 ttl=63 time=5.38 ms
        ...
    Successful on 1 node: agent-centos.localdomain
    Ran on 1 node in 5.65 seconds
    

* Primary interaction is via commandline
* `bolt` is the primary command with various subcommands, like in this case `command run`
* `ping -c 4 8.8.8.8` is the command run on the target node
