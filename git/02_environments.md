!SLIDE small
# Git using Static Puppet Environments

    @@@ Sh
    # tree .
    .
    ├── development
    │   ├── modules
    │   └── manifests/site.pp
    ├── production
    │   ├── modules
    │   └── manifests/site.pp
    └── testing
        ├── modules
        └── manifests/site.pp

    # git checkout -m 'apache-module'
    # cd development/modules/
    # puppet module generate training-apache
    ...
    # git add apache
    # git commit -m 'apache module'
    # git push origin apache-module
    # git checkout master
    # git merge apache-module
    # git push origin master


!SLIDE smbullets
# Dynamic Environments with r10k

* Tool that allows you to manage your environment configurations in a source control repository (Git or SVN)
* Based on the code in your control repo branches, r10k creates environments on your Master (dynamic environments), installs and updates the modules you want in each environment
* `Control Manager` is a replacement for r10k in newer Puppet Enterprise versions (PE 2015.3)


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use r10k

* Objective:
 * Deploy environments and modules with r10k
* Steps:
 * Install `r10k`
 * Initialize a new Git repository
 * Add the content from the `control-repo`
 * Rename the `master` branch to `production`
 * Create a configuration file `r10k.yaml`
 * Deploy the `production` environment
 * Add the `puppetlabs-stdlib` and your `apache` module to the Puppetfile
 * Update the `production` environment
 * Add a new branch `development`
 * Deploy the `development` environment


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use r10k

## Objective:

****

* Deploy environments and modules with r10k

## Steps:

****

* Install `r10k`
* Initialize a new Git repository
* Add the content from the `control-repo`
* Rename the `master` branch to `production`
* Create a configuration file `r10k.yaml`
* Deploy the `production` environment
* Add the `puppetlabs-stdlib` and your `apache` module to the Puppetfile
* Update the `production` environment
* Add a new branch `development`
* Deploy the `development` environment


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use r10k

****

Install `r10k`:

    @@@ Sh
    $ sudo yum install gem
    $ gem install r10k

Initialize a new Git repository:

    @@@ Sh
    $ git init --bare /home/training/puppet.git

Add the content from the `control-repo`:

    @@@ Sh
    $ cd /home/training
    $ git clone https://github.com/puppetlabs/control-repo.git
    $ git clone /home/training/puppet.git /home/training/puppetclone
    $ cp -Rf control-repo/* puppetclone/

Rename the `master` branch to `production`:

    @@@ Sh
    $ cd /home/training/puppetclone/
    $ git add .
    $ git commit -m 'inital commit'
    $ git push origin master
    $ cd /home/training/puppet.git/
    $ git branch -m master production

Create a configuration file `r10k.yaml`:

    @@@ Sh
    $ vim /etc/puppetlabs/puppet/r10k.yaml
    :cachedir: '/tmp/r10k/cache'

    :sources:
      :puppet:
        remote: '/home/training/puppet.git'
        basedir: '/etc/puppetlabs/code/environments'

Deploy the `production` environment:

    @@@ Sh
    $ chown -Rf training:training /etc/puppetlabs/code/environments/
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

Add the `puppetlabs-stdlib` and your `apache` module to the Puppetfile:

    @@@ Sh
    $ vim /home/training/puppetclone/Puppetfile
    mod "puppetlabs/stdlib", :latest
    mod 'apache',
      :git => '/home/training/apache.git'

    $ cd /home/training/puppetclone/
    $ git add Puppetfile
    $ git commit -m 'modules'
    $ git push origin production

Update the `production` environment:

    @@@ Sh
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

Add a new branch `development`:

    @@@ Sh
    $ cd /home/training/puppetclone/
    $ git checkout -b development
    $ git push -u origin development

Deploy the `development` environment:

    @@@ Sh
    $ r10k deploy environment development -p -c /etc/puppetlabs/puppet/r10k.yaml
