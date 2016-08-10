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
 * Add basemodulepath `/home/training/puppet/modules` to `puppet.conf`


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
* Add basemodulepath `/home/training/puppet/modules` to `puppet.conf`


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
    $ sudo ln -s /opt/puppetlabs/puppet/bin/{augtool,facter,mco,puppet} /usr/bin/
    $ puppet --version

Add server and basemodulepath to `puppet.conf`:

    @@@Sh
    $ mkdir /home/training/.puppetlabs/etc/puppet
    $ vim /home/training/.puppetlabs/etc/puppet/puppet.conf
    [main]
      server = puppet.localdomain
      basemodulepath = /home/training/puppet/modules
    $ puppet module list

    $ sudo vim /etc/puppetlabs/puppet/puppet.conf
    [main]
      server = puppet.localdomain
      basemodulepath = /home/training/puppet/modules
    $ sudo puppet module list


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Establish Puppet connection

* Objective:
 * Establish Puppet connection with `puppet.localdomain`
* Steps:
 * Trigger Puppet run on `agent-centos.localdomain`
 * Sign certificate on `puppet.localdomain`
 * Trigger Puppet run on `agent-centos.localdomain`


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Establish Puppet connection

## Objective:

****

* Establish Puppet connection with `puppet.localdomain`

## Steps:

****

* Trigger Puppet run on `agent-centos.localdomain`
* Sign certificate on `puppet.localdomain`
* Trigger Puppet run on `agent-centos.localdomain`


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Establish Puppet connection

****

Trigger Puppet run on `agent-centos.localdomain`:

    @@@Sh
    $ sudo puppet agent -t

Sign certificate on `puppet.localdomain`:

    @@@Sh
    $ sudo puppet cert list
    $ sudo puppet cert sign agent-centos.localdomain
    $ sudo puppet cert list --all

Trigger Puppet run on `agent-centos.localdomain`:

    @@@Sh
    $ sudo puppet agent -t