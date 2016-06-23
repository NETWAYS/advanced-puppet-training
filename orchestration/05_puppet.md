!SLIDE smbullets
# MCollective Puppet Applications

`puppet`

* Manages the on-demand running of your Puppet Agents

`package`

* Uses Puppet RAL to manage package state

`service`

* Uses Puppet RAL to manage service state


!SLIDE small
# puppet Application Usage

Run Puppet on 5 Debian nodes at a time:

    @@@ Sh
    # mco puppet runall -F osfamily=Debian 5

Temporarily disable Puppet on `dev` classified nodes:

    @@@ Sh
    # mco puppet disable -C dev

Retrieve the last run summary from a node:

    @@@ Sh
    # mco puppet summary -I proxy.training.vm


!SLIDE small
# package Application Usage

Install a package on classified nodes:

    @@@ Sh
    # mco package install httpd -C backend

Update a package on a named node:

    @@@ Sh
    # mco package update httpd -I bob.training.vm

Retrieve package versions from all RedHat machines:

    @@@ Sh
    # mco package status httpd -F osfamily=RedHat


!SLIDE small
# service Application Usage

Restart a service on all `travis` classified nodes:

    @@@ Sh
    # mco service travis-ci restart -C travis

Stop a service on a named node:

    @@@ Sh
    # mco service exim stop -I compromised.training.vm

Discover how many mailservers are running:

    @@@ Sh
    # mco service exim status


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
