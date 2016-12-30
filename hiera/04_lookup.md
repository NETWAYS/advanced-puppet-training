!SLIDE small
# lookup Function

* Returns the first value found by default
* Configure it to merge multiple values into one
* Replaces `hiera`, `hiera_array`, and `hiera_hash` functions of old config style Hiera (version 3)
* Adds support for environment data and data in modules


!SLIDE small
# lookup Function Syntax

    @@@Sh
    lookup( <NAME>, [<VALUE TYPE>], [<MERGE BEHAVIOR>], \
      [<DEFAULT VALUE>] )

Look up a key and return the first value found:

    @@@Sh
    lookup('ntp::service_name')

Do a unique merge lookup of class names, then add all of those classes to the catalog (like `hiera_include`):

    @@@Sh
    lookup('classes', Array[String], 'unique').include

Do a deep hash merge lookup of user data, but let higher priority sources remove values by prefixing them with "--":

    @@@Sh
    lookup( { 'name' => 'users',
          'merge' => {
            'strategy'        => 'deep',
            'knockout_prefix' => '--',
          },
    })


!SLIDE small
# CLI Lookup

Puppet apply:

    @@@Sh
    $ puppet apply -e "notice(lookup('message'))"
    $ puppet apply -e "notice(hiera('message'))"

Hiera command line tool:

    @@@Sh
    hiera [options] key [default value] [variable='text'...]
      ...
      -a, --array              Return all values as an array
      -h, --hash               Return all values as a hash
      -c, --config CONFIG      Configuration file
      -j, --json SCOPE         JSON format file to load scope from
      -y, --yaml SCOPE         YAML format file to load scope from
      ...

    $ hiera message ::osfamily=RedHat environment=production \
      -c /etc/puppetlabs/puppet/hiera.yaml


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera (version 3)

* Objective:
 * Create and lookup hierarchy (version 3) on `puppet.localdomain`
* Steps:
 * Add Hiera YAML backend with `/etc/puppetlabs/code/environments/%{environment}/hieradata` as datadir
 * Create hierarchy with fact `osfamily` and `common`
 * Create Hiera files
 * Push your configuration to `production`
 * Deploy the `production` environment with r10k
 * Use `puppet apply` and Hiera CLI tool for lookup


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera (version 3)

## Objective:

****

* Create and lookup hierarchy (version 3) on `puppet.localdomain`

## Steps:

****

* Add Hiera YAML backend with `/etc/puppetlabs/code/environments/%{environment}/hieradata` as datadir
* Create hierarchy with fact `osfamily` and `common`
* Create Hiera files
* Push your configuration to `production`
* Deploy the `production` environment with r10k
* Use `puppet apply`, Hiera CLI and puppet lookup tool for lookup


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Hiera (version 3)

****

Create and lookup hierarchy on `puppet.localdomain`:

    @@@Sh
    $ sudo vim /etc/puppetlabs/puppet/hiera.yaml
    ---
    :backends:
      - yaml

    :hierarchy:
      - "%{::osfamily}"
      - common

    :yaml:
      :datadir: "/etc/puppetlabs/code/environments/%{environment}/hieradata"

    $ cd /home/training/puppet
    $ vim hieradata/RedHat.yaml
    ---
    message: "Value from RedHat.yaml"

    $ vim hieradata/common.yaml
    ---
    message: "This node is using common data"

Push your configuration to `production`:

    @@@Sh
    $ git add hieradata/RedHat.yaml
    $ git commit -m 'hieradata'
    $ git push origin production

Deploy the `production` environment with r10k:

    @@@Sh
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

Use `puppet apply`, Hiera CLI and puppet lookup tool for lookup:

    @@@Sh
    $ sudo puppet apply -e "notice(hiera('message'))"
    $ hiera message ::osfamily=RedHat environment=production -c /etc/puppetlabs/puppet/hiera.yaml
    $ puppet lookup message --node puppet.localdomain --explain


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera (version 4)

* Objective:
 * Create and lookup hierarchy (version 4) on `puppet.localdomain`
* Steps:
 * Configure environment `production` to use its own hierarchy
 * Add Hiera YAML backend to `production` with `data` as datadir
 * Create hierarchy with fact `osfamily` and `common`
 * Create Hiera files
 * Push your configuration to `production`
 * Deploy the `production` environment with r10k
 * Use `puppet apply`, Hiera CLI puppet lookup tool for lookup


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera (version 4)

## Objective:

****

* Create and lookup hierarchy (version 4) on `puppet.localdomain`

## Steps:

****

* Configure environment `production` to use its own hierarchy
* Add Hiera YAML backend to `production` with `data` as datadir
* Create hierarchy with fact `osfamily` and `common`
* Create Hiera files
* Push your configuration to `production`
* Deploy the `production` environment with r10k
* Use `puppet apply`, Hiera CLI puppet lookup tool for lookup


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Hiera (version 4)

****

Configure environment `production` to use its own hierarchy on `puppet.localdomain`:

    @@@Sh
    $ sudo vim /etc/puppetlabs/code/environments/production/environment.conf
    ...
    environment_data_provider = hiera

Create a lookup hierarchy for environment `production` on `puppet.localdomain`:

    @@@Sh
    $ sudo vim /etc/puppetlabs/code/environments/production/hiera.yaml
    ---
    :version: 4
    :datadir: data
    :hierarchy:
      - name: "%{::osfamily}"
        backend: yaml

      - name: "common"
        backend: yaml

    $ cd /home/training/puppet
    $ mkdir data
    $ vim data/RedHat.yaml
    ---
    message: "v4: Value from RedHat.yaml"

    $ vim data/common.yaml
    ---
    message: "v4: This node is using common data"

Push your configuration to `production`:

    @@@Sh
    $ git add environment.conf
    $ git add hiera.yaml
    $ git add data
    $ git commit -m 'data for hiera v4'
    $ git push origin production

Deploy the `production` environment with r10k:

    @@@Sh
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

Use `puppet apply`, Hiera CLI and puppet lookup tool for lookup:

    @@@Sh
    $ sudo puppet apply -e "notice(hiera('message'))"
    $ hiera message ::osfamily=RedHat environment=production -c /etc/puppetlabs/puppet/hiera.yaml
    $ puppet lookup message --node puppet.localdomain --explain
