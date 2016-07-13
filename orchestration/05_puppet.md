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
    $ mco puppet runall -F osfamily=Debian 5

Temporarily disable Puppet on `dev` classified nodes:

    @@@ Sh
    $ mco puppet disable -C dev

Retrieve the last run summary from a node:

    @@@ Sh
    $ mco puppet summary -I proxy.training.vm


!SLIDE small
# package Application Usage

Install a package on classified nodes:

    @@@ Sh
    $ mco package install httpd -C backend

Update a package on a named node:

    @@@ Sh
    $ mco package update httpd -I bob.training.vm

Retrieve package versions from all RedHat machines:

    @@@ Sh
    $ mco package status httpd -F osfamily=RedHat


!SLIDE small
# service Application Usage

Restart a service on all `travis` classified nodes:

    @@@ Sh
    $ mco service travis-ci restart -C travis

Stop a service on a named node:

    @@@ Sh
    $ mco service exim stop -I compromised.training.vm

Discover how many mailservers are running:

    @@@ Sh
    $ mco service exim status


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add MCollective Puppet Plugin 

* Objective:
 * Add MCollective Puppet Agent Plugin
* Steps:
 * Install MCollective Puppet Agent Plugin
 * Test Puppet orchestration
 * Optional: Use Puppet to get the facts inventory up and running


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add MCollective Puppet Plugin

## Objective:

****

* Add MCollective Puppet Agent Plugin

## Steps:

****

* Install MCollective Puppet Agent Plugin
* Test Puppet orchestration

### Optional

* Use Puppet to get the facts inventory up and running


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add MCollective Puppet Plugin

****

### Install MCollective Puppet Agent Plugin:

    @@@ Sh
    $ sudo git clone https://github.com/puppetlabs/mcollective-puppet-agent /opt/puppetlabs/mcollective/plugins/mcollective
    $ sudo systemctl restart mcollective.service

### Test Puppet orchestration:

Behaviour changes depending on the fact if the agent is running or not. If it is running commands like `runonce` will take
place immediately but can not take arguments like `--noop`. If it is stopped commands will be splayed by default.

    @@@ Sh
    $ mco puppet status
    $ mco puppet runonce --no-splay
    $ sleep 10
    $ mco puppet status
    $ mco puppet summary

### Use Puppet to get the facts inventory up and running

There is also an agent for gathering the facts but it can be quite slow, so the default is using a precreated yaml inventory.
How to get this up and running is explained in https://docs.puppet.com/mcollective/plugin_directory/facter_via_yaml.html.

Alternative add a fact manually to the file `/etc/puppetlabs/mcollective/facts.yaml` for testing.

    @@@ Sh
    $ echo "osfamily: RedHat" >> /etc/puppetlabs/mcollective/facts.yaml
    $ mco puppet runonce -F osfamily=Debian
    $ mco puppet runonce -F osfamily=RedHat
