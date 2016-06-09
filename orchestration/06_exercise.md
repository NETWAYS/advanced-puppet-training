!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add MCollective Puppet Plugin 

* Objective:
 * Add MCollective Puppet Agent Plugin
* Steps:
 * Install MCollective Puppet Agent Plugin
 * Test Puppet orchestration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add MCollective Puppet Plugin

## Objective:

****

* Add MCollective Puppet Agent Plugin

## Steps:

****

* Install MCollective Puppet Agent Plugin
* Test Puppet orchestration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add MCollective Puppet Plugin

****

Install MCollective Puppet Agent Plugin:

    @@@ Sh
    # yum install mcollective-puppet-agent

Test Puppet orchestration:

    @@@ Sh
    # mco rpc puppet runonce
