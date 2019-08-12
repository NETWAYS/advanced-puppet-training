!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Build a Module Tarball

* Objective:
 * Build a tarball of the `apache` module
* Steps:
 * Prepare your `apache` module
 * Write a `metadata.json` file
 * Install package dependencies
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
* Install package dependencies
* Build an uploadable tarball


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Build a Module Tarball

****

Write a `metadata.json` file:

    @@@Sh
    $ cd /home/training/puppet/modules
    $ vim apache/metadata.json
    {
      "name": "training-apache",
      "version": "0.1.0",
      "author": "training",
      "summary": "Installs, configures and manages the Apache service",
      "license": "Apache-2.0",
      "source": "git://github.com/training/training-apache.git",
      "project_page": "http://github.com/training/training-apache",
      "issues_url": null,
      "tags": ["apache", "httpd"],
      "operatingsystem_support": [
        {
          "operatingsystem":"RedHat",
          "operatingsystemrelease":[ "6", "7" ]
        },
        {
        "operatingsystem": "Ubuntu",
        "operatingsystemrelease": [ "12.04" ]
        }
      ],
      "dependencies": [
        {
          "name": "puppetlabs-stdlib",
          "version_requirement": ">= 1.0.0"
        }
      ],
    }

Install package dependencies:

    @@@Sh
    $ puppet module install puppetlabs-stdlib

Build an uploadable tarball:

    @@@Sh
    $ puppet module build apache
    Notice: Building /home/training/puppet/modules/apache for release
    Module built: /home/training/puppet/modules/apache/pkg/training-apache-0.1.0.tar.gz
