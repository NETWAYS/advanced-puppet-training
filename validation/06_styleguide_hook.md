!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Style Guide Checking

* Objective:
 * Add a pre-commit hook for Puppet Lint checking on `agent-centos.localdomain`
* Steps:
 * Install `puppet-lint` via `yum` or `gem`
 * Clone `https://github.com/drwahl/puppet-git-hooks` repo
 * Symlink the pre-commit file to `.git/hooks/pre-commit` of your cloned `apache` repository
 * Produce a style guide error and test the pre-commit hook


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Style Guide Checking

## Objective:

****

* Add a pre-commit hook for Puppet Lint checking on `agent-centos.localdomain`

## Steps:

****

* Install `puppet-lint` via `yum` or `gem`
* Clone `https://github.com/drwahl/puppet-git-hooks` repo
* Symlink the pre-commit file to `.git/hooks/pre-commit` of your cloned `apache` repository
* Produce a style guide error and test the pre-commit hook


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add a Pre-Commit Hook for Style Guide Checking on `agent-centos.localdomain`

****

Install `puppet-lint` via `yum` (requires EPEL repository):

    @@@Sh
    $ sudo yum install rubygem-puppet-lint

Install `puppet-lint` via `gem` (gives typically a newer version):

    @@@Sh
    $ gem install puppet-lint

Clone `https://github.com/drwahl/puppet-git-hooks` repo:

    @@@Sh
    $ cd /home/training/
    $ git clone https://github.com/drwahl/puppet-git-hooks.git

Symlink the pre-commit file to `.git/hooks/pre-commit` of your cloned `apache` repository:

    @@@Sh
    $ ln -s /home/training/puppet-git-hooks/pre-commit /home/training/puppet/modules/apache/.git/hooks/pre-commit

Produce a style guide error and test the pre-commit hook on `agent-centos.localdomain`:

    @@@Sh
    $ cd /home/training/puppet/modules
    $ vim apache/manifests/init.pp
    class apache {
    ...

    $ git add apache/manifests/init.pp
    $ git commit -m 'lint check'
    Checking puppet manifest syntax for production/modules/apache/manifests/init.pp...
    Checking puppet style guide compliance for production/modules/apache/manifests/init.pp...
    production/modules/apache/manifests/init.pp - WARNING: class not documented on line 1
    Error: styleguide violation in production/modules/apache/manifests/init.pp (see above)
    Error: 1 styleguide violation(s) found. Commit will be aborted.
    Please follow the puppet style guide outlined at:
    http://docs.puppetlabs.com/guides/style_guide.html
    rspec not installed. Skipping rspec-puppet tests...
    r10k not installed. Skipping r10k Puppetfile test...
    Error: 1 subhooks failed. Aborting commit.
