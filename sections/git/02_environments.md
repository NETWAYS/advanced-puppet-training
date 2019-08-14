!SLIDE small
# Git using Static Puppet Environments

    @@@Sh
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


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use r10k

* Objective:
 * Deploy environments and modules with r10k
* Steps:
 * Install `r10k` on `puppet.localdomain`
 * Initialize a new Git repository
 * Clone the repository and create a new branch `production`
 * Add the content from the `control-repo`
 * Create a configuration file `r10k.yaml`
 * Deploy the `production` environment
 * Add the `puppetlabs-stdlib` and your `apache` module to the Puppetfile
 * Update the `production` environment
* Bonus:
 * Add a new branch `development`
 * Deploy the `development` environment


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use r10k

## Objective:

****

* Deploy environments and modules with r10k

## Steps:

****

* Install `r10k` on `puppet.localdomain`
* Initialize a new Git repository
* Clone the repository and create a new branch `production`
* Add the content from the `control-repo`
* Create a configuration file `r10k.yaml`
* Deploy the `production` environment
* Add the `puppetlabs-stdlib` and your `apache` module to the Puppetfile
* Update the `production` environment

## Bonus:

* Add a new branch `development`
* Deploy the `development` environment


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use r10k

****

Install `r10k` on `puppet.localdomain`:

    @@@Sh
    training@puppet $ sudo /opt/puppetlabs/puppet/bin/gem install r10k

Initialize a new Git repository:

    @@@Sh
    training@puppet $ git init --bare /home/training/puppet.git

Clone the repository and create a new branch `production`:

    @@@Sh
    training@puppet $ git clone /home/training/puppet.git /home/training/puppet
    training@puppet $ cd /home/training/puppet
    training@puppet $ git checkout -b production

Add the content from the `control-repo`:

    @@@Sh
    training@puppet $ cd /home/training
    training@puppet $ git clone https://github.com/puppetlabs/control-repo.git
    training@puppet $ cp -Rf control-repo/* puppet/
    training@puppet $ cd /home/training/puppet
    training@puppet $ git add .
    training@puppet $ git commit -m 'inital commit'
    training@puppet $ git push origin production

Create a configuration file `r10k.yaml`:

    @@@Sh
    training@puppet $ sudo vim /etc/puppetlabs/puppet/r10k.yaml
    :cachedir: '/tmp/r10k/cache'

    :sources:
      :puppet:
        remote: '/home/training/puppet.git'
        basedir: '/etc/puppetlabs/code/environments'

Deploy the `production` environment:

    @@@Sh
    training@puppet $ sudo chown -Rf training:training /etc/puppetlabs/code/environments/
    training@puppet $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

~~~PAGEBREAK~~~

Add the `puppetlabs-stdlib` and your `apache` module to the Puppetfile:

    @@@Sh
    training@puppet $ vim /home/training/puppet/Puppetfile
    mod "puppetlabs/stdlib", :latest
    mod 'apache',
      :git => '/home/training/apache.git'

    training@puppet $ cd /home/training/puppet/
    training@puppet $ git add Puppetfile
    training@puppet $ git commit -m 'modules'
    training@puppet $ git push origin production

Update the `production` environment:

    @@@Sh
    training@puppet $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

## Bonus:

Add a new branch `development`:

    @@@Sh
    training@puppet $ cd /home/training/puppet/
    training@puppet $ git checkout -b development
    training@puppet $ git push -u origin development

Deploy the `development` environment:

    @@@Sh
    training@puppet $ r10k deploy environment development -p -c /etc/puppetlabs/puppet/r10k.yaml
