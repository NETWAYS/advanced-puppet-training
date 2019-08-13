!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Style Guide Checking

* Objective:
 * Add a client side pre-commit hook for Puppet Lint checking on `agent-centos.localdomain`
* Steps:
 * Install `puppet-lint` via gem
 * Check config `commit_hooks/config.cfg`
 * Produce a style guide error and test the pre-commit hook


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Style Guide Checking

## Objective:

****

* Add a client side pre-commit hook for Puppet Lint checking on `agent-centos.localdomain`

## Steps:

****

* Install `puppet-lint` via gem
* Check config `commit_hooks/config.cfg`
* Produce a style guide error and test the pre-commit hook


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add a Client side Pre-Commit Hook for Style Guide Checking

****

Install `puppet-lint` via gem:

    @@@Sh
    $ sudo gem install puppet-lint

Check config `commit_hooks/config.cfg`:

    @@@Sh
    $ vim /usr/local/share/puppet-git-hooks/commit_hooks/config.cfg
    CHECK_PUPPET_LINT="enabled"
    ...

Remove all lines of documentation from a file and test the pre-commit hook on `agent-centos.localdomain`:

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
    Error: 1 subhooks failed. Aborting commit.
