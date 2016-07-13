!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Syntax Checking

* Objective:
 * Add a pre-commit hook for Puppet manifest syntax checking
* Steps:
 * Create a new file in your git repository `.git/hooks/pre-commit`
 * Insert the content of `puppet_manifest_syntax_check.sh` from  `https://github.com/drwahl/puppet-git-hooks`
 * Grant execute permissions on `.git/hooks/pre-commit`
 * Produce a syntax error and test the pre-commit hook


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Add a Pre-Commit Hook for Syntax Checking

## Objective:

****

* Add a pre-commit hook for Puppet manifest syntax checking

## Steps:

****

* Create a new file in your git repository `.git/hooks/pre-commit` 
* Insert the content of `puppet_manifest_syntax_check.sh` from  `https://github.com/drwahl/puppet-git-hooks`
* Grant execute permissions on `.git/hooks/pre-commit`
* Produce a syntax error and test the pre-commit hook


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Add a Pre-Commit Hook for Syntax Checking

****

Create a new file in your git repository `.git/hooks/pre-commit`:

    @@@ Sh
    $ touch /home/training/puppet/.git/hooks/pre-commit

Insert the content of `puppet_manifest_syntax_check.sh` from  `https://github.com/drwahl/puppet-git-hooks`:

    @@@ Sh
    $ vim /home/training/puppet/.git/hooks/pre-commit
    #!/bin/bash

    # This script expects $1 to be passed and for $1 to be the filesystem location
    # to a puppet manifest file for which it will run syntax checks against.

    manifest_path="$1"
    module_dir="$2"
    USE_PUPPET_FUTURE_PARSER="$3"

    syntax_errors=0
    error_msg=$(mktemp /tmp/error_msg_puppet-syntax.XXXXX)

    if [[ $module_dir ]]; then
        manifest_name="${manifest_path##*$module_dir}"
        error_msg_filter="sed -e s|$module_dir||"
    else
        manifest_name="$manifest_path"
        error_msg_filter="sed"
    fi

    # Get list of new/modified manifest and template files to check (in git index)
    # Check puppet manifest syntax
    echo -e "$(tput setaf 6)Checking puppet manifest syntax for $manifest_name...$(tput sgr0)"
    if [[ $USE_PUPPET_FUTURE_PARSER != "enabled" ]]; then
        puppet parser validate --color=false "$1" > "$error_msg" 2>&1
    else
        puppet parser validate --parser future --color=false "$1" > "$error_msg" 2>&1
    fi

    if [[ $? -ne 0 ]]; then
      syntax_errors=$((syntax_errors + 1))
        $error_msg_filter -e "s/^/$(tput setaf 1)/" -e "s/$/$(tput sgr0)/" < "$error_msg"
        echo -e "$(tput setaf 1)Error: puppet syntax error in $manifest_name (see above)$(tput sgr0)"
    fi
    rm -f "$error_msg"

    if [[ $syntax_errors -ne 0 ]]; then
        echo -e "$(tput setaf 1)Error: $syntax_errors syntax error(s) found in puppet manifests. Commit will be aborted.$(tput sgr0)"
        exit 1
    fi

    exit 0

Grant execute permissions on `.git/hooks/pre-commit`:

    @@@ Sh
    $ chmod +x /home/training/puppet/.git/hooks/pre-commit

~~~PAGEBREAK~~~

Produce a syntax error and test the pre-commit hook:

    @@@ Sh
    $ vim /home/training/puppet/modules/apache/manifests/init.pp
    class apache {
    ...

    $ cd /home/training/puppet/
    $ git add modules/apache/manifests/init.pp
    $ git commit -m 'syntax check'
    Checking puppet manifest syntax for ...
    Error: One or more file(s) specified did not exist:
    ["   \n"]
    Error: Try 'puppet help parser validate' for usage
    Error: puppet syntax error in  (see above)
    Error: 1 syntax error(s) found in puppet manifests. Commit will be aborted.
