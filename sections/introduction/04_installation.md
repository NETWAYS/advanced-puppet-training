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
    $ scp /home/training/apache.tar.gz agent-centos.localdomain:/home/training/puppet/modules/
    $ ssh agent-centos.localdomain
    $ cd /home/training/puppet/modules
    $ tar -xf apache.tar.gz

Add puppet repository from http://yum.puppetlabs.com:

    @@@ Sh
    $ sudo rpm -ivh http://yum.puppetlabs.com/puppet6-release-el-7.noarch.rpm

Inspect what version is installed on your master:

    @@@ Sh
    $ sudo rpm -aq |grep puppet-agent
    puppet-agent-x.y.z-n.el7.x86_64

Install package `puppet-agent`:

    @@@ Sh
    $ sudo yum install puppet-agent-x.y.z-n.el7.x86_64

Add symlinks for most used commands to `/usr/bin`:

    @@@ Sh
    $ sudo ln -s /opt/puppetlabs/puppet/bin/{augtool,facter,mco,puppet,rake} /usr/bin/
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
    $ sudo puppetserver ca list
    $ sudo puppetserver ca sign --certname agent-centos.localdomain
    $ sudo puppetserver ca list --all

Trigger Puppet run on `agent-centos.localdomain`:

    @@@Sh
    $ sudo puppet agent -t
