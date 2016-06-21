!SLIDE small
# Profiles

    @@@ Puppet
    class profile::myapp {
      include tomcat
      include mysql

      class { '::myapp':
        db_engine => 'mysql',
        db_host   => 'localhost',
      }
    }

* Break everything down into components
* Think about what things actually are instead of just what they look like
* Look for overlap and similarities in application stacks
* Reduce each application into granular Puppet modules
* Create a code layer responsible for implementation


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Profiles

* Objective:
 * Create `database` and `webserver` profiles
* Steps:
 * Install `puppetlabs-mysql` module
 * Create a `database` profile for mysql
 * Create a `webserver` profile for apache
 * Test and apply your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Profiles

## Objective:

****

* Create `database` and `webserver` profiles

## Steps:

****

* Install `puppetlabs-mysql` module
* Create a `database` profile for mysql
* Create a `webserver` profile for apache
* Test and apply your configuratio


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Designing Profiles

****


    @@@ Sh
    # puppet module install puppetlabs-mysql

    # vim /etc/puppetlabs/code/environments/production/modules/profiles/manifests/database.pp
    class profiles::database {
      class { '::mysql::server':
        root_password           => 'swordfish',
        remove_default_accounts => true,
      }

      mysql_database { 'information_schema':
        ensure  => 'present',
        charset => 'utf8',
        collate => 'utf8_general_ci',
      }

      mysql_database { 'mysql':
        ensure  => 'present',
        charset => 'latin1',
        collate => 'latin1_swedish_ci',
      }

      mysql_database { 'performance_schema':
        ensure  => 'present',
       charset => 'utf8',
       collate => 'utf8_general_ci',
      }
    }

    # puppet parser validate /etc/puppet/code/modules/profiles/manifests/database.pp
    # vim /etc/puppet/code/modules/profiles/examples/database.pp
    include profiles::database

    # puppet parser validate /etc/puppet/code/modules/profiles/examples/database.pp
    # puppet apply --noop /etc/puppet/code/modules/profiles/examples/database.pp
    # puppet apply /etc/puppet/code/modules/profiles/examples/database.pp

    # vim /etc/puppet/code/modules/profiles/manifests/webserver.pp
    class profiles::webserver {
      include apache::stages
      include apache

      class { 'apache::yumrepos':
        stage => 'yum',
      }
    }

    # puppet parser validate /etc/puppet/codei/modules/profiles/manifests/webserver.pp
    # vim /etc/puppet/code/modules/profiles/examples/webserver.pp
    include profiles::webserver

    # puppet parser validate /etc/puppet/code/modules/profiles/examples/webserver.pp
    # puppet apply --noop /etc/puppet/code/modules/profiles/examples/webserver.pp
    # puppet apply /etc/puppet/code/modules/profiles/examples/webserver.pp
