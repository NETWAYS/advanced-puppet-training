!SLIDE small
# lookup Function

* Returns the first value found by default
* Configure it to merge multiple values into one
* Replaces `hiera`, `hiera_array`, and `hiera_hash` functions of Hiera 3
* Adds support for environment data and data in modules


!SLIDE small
# lookup Function Syntax

    lookup( <NAME>, [<VALUE TYPE>], [<MERGE BEHAVIOR>], \
      [<DEFAULT VALUE>] )

Look up a key and return the first value found:

    lookup('ntp::service_name')

Do a unique merge lookup of class names, then add all of those classes to the catalog (like `hiera_include`):

    lookup('classes', Array[String], 'unique').include

Do a deep hash merge lookup of user data, but let higher priority sources remove values by prefixing them with "--":

    lookup( { 'name' => 'users',
          'merge' => {
            'strategy'        => 'deep',
            'knockout_prefix' => '--',
          },
    })


!SLIDE small
# CLI Lookup

Puppet apply:

    @@@ Sh
    # puppet apply -e "notice(lookup('message'))"
    # puppet apply -e "notice(hiera('message'))"

Hiera command line tool:

    @@@ Sh
    hiera [options] key [default value] [variable='text'...]
      ...
      -a, --array              Return all values as an array
      -h, --hash               Return all values as a hash
      -c, --config CONFIG      Configuration file
      -j, --json SCOPE         JSON format file to load scope from
      -y, --yaml SCOPE         YAML format file to load scope from
      ...

    # hiera message ::osfamily=RedHat environment=production \
      -c /etc/puppet/hiera.yaml


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera

* Objective:
 * Create and lookup hierarchy
* Steps:
 * Add Hiera YAML backend with `/etc/puppetlabs/code/environments/%{environment}/hieradata` as datadir
 * Create hierarchy with fact `osfamily` and `common`
 * Create Hiera files
 * Use `puppet apply` for lookup
 * Use Hiera CLI tool for lookup


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera

## Objective:

****

* Create and lookup hierarchy

## Steps:

****

* Add Hiera YAML backend with `/etc/puppetlabs/code/environments/%{environment}/hieradata` as datadir
* Create hierarchy with fact `osfamily` and `common`
* Create Hiera files
* Use `puppet apply` for lookup
* Use Hiera CLI tool for lookup


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Hiera

****

    @@@ Sh
    # vim /etc/puppetlabs/puppet/hiera.yaml
    ---
    :backends:
      - yaml

    :hierarchy:
      - "%{::osfamily}"
      - common 

    :yaml:
      :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"

    # vim /etc/puppetlabs/code/environments/production/RedHat.yaml
    message: "Value from RedHat.yaml"

    # vim /etc/puppetlabs/code/environments/production/common.yaml
    message: "Value from common.yaml"

    # puppet apply -e "notice(hiera('message'))"
    # hiera message ::osfamily=RedHat environment=production -c /etc/puppetlabs/puppet/hiera.yaml
