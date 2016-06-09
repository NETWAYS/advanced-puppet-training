!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Build a Module Tarball

* Objective:
 * Build a tarball of the `apache` module
* Steps:
 * Prepare your `apache` module
 * Write a `metadata.json` file
 * Build an uploadable tarball


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Build a Module Tarball

## Objective:

****

* Build a tarball of the `apache` module

## Steps:

****

* Prepare your `apache` module
* Write a `metadata.json` file 
* Build an uploadable tarball


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Build a Module Tarball

****

Write a `metadata.json` file:

    @@@ Sh
    # vim /etc/puppet/modules/apache/metadata.json
    {
      "name": "training-apache",
      "version": "0.1.0",
      "author": "training",
      "summary": "Installs, configures and manages the Apache service",
      "license": "Apache 2.0",
      "source": "git://github.com/training/training-apache.git",
      "project_page": "http://github.com/training/training-apache",
      "issues_url": null,
      "dependencies": [
        {
          "name": "puppetlabs-stdlib",
          "version_range": ">= 1.0.0"
        }
      ]
    }

Build an uploadable tarball:

    @@@ Sh
    # puppet module build /etc/puppet/modules/apache
    Notice: Building /etc/puppet/modules/apache for release
    Module built: /etc/puppet/modules/apache/pkg/training-apache-0.1.0.tar.gz
