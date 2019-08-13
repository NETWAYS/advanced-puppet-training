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
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera

* Objective:
 * Create and lookup hierarchy
* Steps:
 * Add Hiera YAML backend to the production environment
 * Create hierarchy with fact `osfamily` and `common`
 * Create Hiera files
 * Push your configuration to `production`
 * Deploy the `production` environment with r10k
 * Use `puppet apply` and Hiera CLI tool for lookup


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera (version 3)

## Objective:

****

* Create and lookup hierarchy

## Steps:

****

* Add Hiera YAML backend to the production environment
* Create hierarchy with fact `osfamily` and `common`
* Create Hiera files
* Push your configuration to `production`
* Deploy the `production` environment with r10k
* Use `puppet apply`, Hiera CLI and puppet lookup tool for lookup


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Hiera

****

Create and lookup hierarchy for environment production:

    @@@Sh
    $ vim /home/training/puppet/hiera.yaml
    ---
    version: 5
    defaults:
      datadir: data
      data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "%{trusted.certname}.yaml"
  - name: "Other YAML hierarchy levels"
    paths:
      - "%{::osfamily}.yaml"
      - "common.yaml"

    $ cd /home/training/puppet
    $ mkdir data
    $ vim data/RedHat.yaml
    ---
    message: "Value from RedHat.yaml"

    $ vim data/common.yaml
    ---
    message: "This node is using common data"

Push your configuration to `production`:

    @@@Sh
    $ git add hiera.yaml
    $ git add data/RedHat.yaml
    $ git commit -m 'hiera data'
    $ git push origin production

Deploy the `production` environment with r10k:

    @@@Sh
    $ r10k deploy environment production -p -c /etc/puppetlabs/puppet/r10k.yaml

Use `puppet apply`, Hiera CLI and puppet lookup tool for lookup:

    @@@Sh
    $ sudo puppet apply -e "notice(hiera('message'))"
    $ puppet lookup message --node puppet.localdomain --explain
