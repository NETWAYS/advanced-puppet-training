!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add Orchestration

* Objective:
 * Add orchestration using bolt
* Steps:
 * Install bolt
 * Test orchestration

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add Orchestration

## Objective:

****

* Add orchestration using bolt

## Steps:

****

* Install bolt

It's part of the same repository that pdk is: https://yum.puppet.com/puppet-tools-release-el-7.noarch.rpm

* Test orchestration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add Orchestration

****

Install bolt:

    @@@Sh
    training@puppet $ sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-el-7.noarch.rpm
    training@puppet $ sudo yum install puppet-bolt

Test orchestration on a machine:

    @@@ Sh
    $ bolt command run 'ping -c 4 8.8.8.8' --nodes agent-centos.localdomain
    agent-centos.localdomain      time=41.53 ms
    puppet.localdomain            time=75.71 ms

In a productive environment you should not run a message queue without securing it!
`bolt command run <COMMAND> --nodes -u training -p`

`-u` stands for user and
`-p` for password
