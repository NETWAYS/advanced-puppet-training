!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Puppet Agent

* Objective:
 * Prepare Puppet Agent for later use on `agent-centos.localdomain`
* Steps:
 * Copy `apache.tar.gz` to `agent-centos.localdomain` and extract it
 * Add puppet repository from http://yum.puppetlabs.com
 * Install package `puppet-agent`
 * Add symlinks for most used commands to `/usr/bin` 
 * Add server `puppet.localdomain` to `puppet.conf`
 * Add basemodulepath to `puppet.conf`


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Puppet Agent

## Objective:

****

* Prepare Puppet Agent for later use on `agent-centos.localdomain`

## Steps:

****

* Copy `apache.tar.gz` to `agent-centos.localdomain` and extract it
* Add puppet repository from http://yum.puppetlabs.com
* Install package `puppet-agent`
* Add symlinks for most used commands to `/usr/bin`
* Add server `puppet.localdomain` to `puppet.conf`
* Add basemodulepath to `puppet.conf`


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Prepare Puppet Agent

****

Copy `apache.tar.gz` to `agent-centos.localdomain`:

    @@@ Sh
    $ scp /home/training/apache.tar.gz agent-centos.localdomain:/home/training/puppet/modules/
    $ ssh agent-centos.localdomain
    $ cd /home/training/puppet/modules
    $ tar -xf apache.tar.gz

Add puppet repository from http://yum.puppetlabs.com:

    @@@ Sh
    $ sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

Install package `puppet-agent`:

    @@@ Sh
    $ sudo yum install puppet-agent

Add symlinks for most used commands to `/usr/bin`:

    @@@ Sh
    $ sudo ln -s /opt/puppetlabs/puppet/bin/{augtool,facter,puppet} /usr/bin/

Add server and basemodulepath to `puppet.conf`:

    @@@Sh
    $ vim /home/training/.puppetlabs/etc/puppet/puppet.conf
    [main]
      server = puppet.localdomain
      basemodulepath = /home/training/puppet/modules

    $ vim /etc/puppetlabs/puppet/puppet.conf
    [main]
      server = puppet.localdomain
      basemodulepath = /home/training/puppet/modules
