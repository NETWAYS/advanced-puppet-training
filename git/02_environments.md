!SLIDE small
# Static Puppet Environments

    @@@ Puppet
    [main]
    server = puppet.example.com
    environment = production
    confdir = /etc/puppet

    [agent]
    report = true
    show_diff = true

    [production]
    manifest = /etc/puppet/environments/production/manifests/site.pp
    modulepath = /etc/puppet/environments/production/modules

    [testing]
    manifest = /etc/puppet/environments/testing/manifests/site.pp
    modulepath = /etc/puppet/environments/testing/modules

    [development]
    manifest = /etc/puppet/environments/development/manifests/site.pp
    modulepath = /etc/puppet/environments/development/modules


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
