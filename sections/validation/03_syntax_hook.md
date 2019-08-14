!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Syntax Checking

* Objective:
 * Add a pre-commit hook for Puppet manifest syntax checking to your local apache repository on `agent-centos.localdomain`.
* Steps:
 * Clone `https://github.com/drwahl/puppet-git-hooks`
 * Configure commit_hooks/config.cfg
 * Install pre-commit hooks of `puppet-git-hooks`
 * Produce a syntax error and test the pre-commit hook


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Syntax Checking

## Objective:

****

* Add a pre-commit hook for Puppet manifest syntax checking to your local apache repository on `agent-centos.localdomain`.

## Steps:

****

* Clone `https://github.com/drwahl/puppet-git-hooks`
* Configure commit_hooks/config.cfg
* Install pre-commit hooks of `puppet-git-hooks`
* Produce a syntax error and test the pre-commit hook


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add a Pre-Commit Hook for Syntax Checking

****

Clone `https://github.com/drwahl/puppet-git-hooks`:

    @@@Sh
    training@puppet $ cd /usr/local/share
    training@puppet $ sudo git clone https://github.com/drwahl/puppet-git-hooks.git

Configure commit_hooks/config.cfg:

    @@@Sh
    training@puppet $ sudo vim puppet-git-hooks/commit_hooks/config.cfg
    CHECK_PUPPET_LINT="enabled"
    USE_PUPPET_FUTURE_PARSER="disabled"
    CHECK_INITIAL_COMMIT="disabled"
    CHECK_RSPEC="disabled"
    export PUPPET_LINT_OPTIONS=""
    export PUPPET_LINT_FAIL_ON_WARNINGS="true"
    UNSET_RUBY_ENV="enabled"

Install pre-commit hooks of `puppet-git-hooks`:

    @@@Sh
    training@puppet $ puppet-git-hooks/deploy-git-hook -d ~training/puppet/modules/apache -c

Produce a syntax error and test the pre-commit hook:

    @@@ Sh
    training@puppet $ cd ~/training/puppet/modules/apache
    training@puppet $ vim manifests/params.pp
    class apache::params {
    ...

    training@puppet $ git add manifests/params.pp
    training@puppet $ git commit -m 'syntax check'
    Error: puppet syntax error in manifests/params.pp (see above)
    Error: 1 syntax error(s) found in puppet manifests. Commit will be aborted.
    puppet-lint not installed. Skipping puppet-lint tests...
    Error: 1 subhooks failed. Please fix above errors.
