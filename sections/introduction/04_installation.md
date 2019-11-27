!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Puppet Agent

* Objective:
 * Prepare Puppet Agent for later use on `agent-centos.localdomain`
* Steps:
 * Copy `apache.tar.gz` to `agent-centos.localdomain`, extract it.
 * Add puppet repository from http://yum.puppetlabs.com.
 * Install package `puppet-agent` in the same version as the master runs.
 * Add symlinks for most used commands to `/usr/bin`.
 * Add server `puppet.localdomain` to `puppet.conf`.
 * Add basemodulepath `/home/training/puppet/modules` to `puppet.conf`.

Never run newer puppet versions on your agents than on the master!

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Prepare Puppet Agent

## Objective:

****

* Prepare Puppet Agent for later use on `agent-centos.localdomain`.

## Steps:

****

* Copy `apache.tar.gz` to `agent-centos.localdomain` and extract it.
* Add puppet repository from http://yum.puppetlabs.com.
* Install package `puppet-agent` in the same version as the master runs.
* Add symlinks for most used commands to `/usr/bin`.
* Add server `puppet.localdomain` to `puppet.conf`.
* Add basemodulepath `/home/training/puppet/modules` to `puppet.conf`.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Prepare Puppet Agent

****

Copy `apache.tar.gz` to `agent-centos.localdomain`:

    @@@ Sh
    training@agent $ scp /home/training/apache.tar.gz agent-centos.localdomain:/home/training/puppet/modules/
    training@agent $ ssh agent-centos.localdomain
    training@agent $ cd /home/training/puppet/modules
    training@agent $ tar -xf apache.tar.gz

Add puppet repository from http://yum.puppetlabs.com:

    @@@ Sh
    training@agent $ sudo rpm -ivh http://yum.puppetlabs.com/puppet6-release-el-7.noarch.rpm

Inspect what version is installed on your master:

    @@@ Sh
    training@puppet $ sudo rpm -aq |grep puppet-agent
    puppet-agent-x.y.z-n.el7.x86_64

Install package `puppet-agent`:

    @@@ Sh
    training@agent $ sudo yum install puppet-agent-x.y.z-n.el7.x86_64

Add symlinks for most used commands to `/usr/bin`:

    @@@ Sh
    training@agent $ sudo ln -s /opt/puppetlabs/puppet/bin/{augtool,facter,puppet,rake} /usr/bin/
    training@agent $ puppet --version

Add server and basemodulepath to `puppet.conf`:

    @@@Sh
    training@agent $ mkdir /home/training/.puppetlabs/etc/puppet
    training@agent $ vim /home/training/.puppetlabs/etc/puppet/puppet.conf
    [main]
      server = puppet.localdomain
      basemodulepath = /home/training/puppet/modules
    training@agent $ puppet module list

    training@agent $ sudo vim /etc/puppetlabs/puppet/puppet.conf
    [main]
      server = puppet.localdomain
      basemodulepath = /home/training/puppet/modules
    training@agent $ sudo puppet module list


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
    training@agent $ sudo puppet agent -t

Sign certificate on `puppet.localdomain`:

    @@@Sh
    training@puppet $ sudo puppetserver ca list
    training@puppet $ sudo puppetserver ca sign --certname agent-centos.localdomain
    training@puppet $ sudo puppetserver ca list --all

Trigger Puppet run on `agent-centos.localdomain`:

    @@@Sh
    training@agent $ sudo puppet agent -t
