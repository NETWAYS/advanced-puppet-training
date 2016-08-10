!SLIDE small
# Profiles

    @@@Puppet
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


!SLIDE smbullets noprint
# Mapping Nodes to Profiles

* Modules are grouped to profiles

<center><img src="../_images/roles_profiles/profile_classification.png" style="width:800px;height:204px;" alt="Profile Classification"/></center>


!SLIDE smbullets printonly
# Mapping Nodes to Profiles

* Modules are grouped to profiles

<center><img src="../_images/roles_profiles/profile_classification.png" style="width:470px;height:120px;" alt="Profile Classification"/></center>


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Profiles

* Objective:
 * Create `database` and `webserver` profiles on `agent-centos.localdomain`
* Steps:
 * Install `puppetlabs-mysql` module
 * Create a `database` profile for mysql
 * Create a `webserver` profile for apache
 * Test and apply your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Profiles

## Objective:

****

* Create `database` and `webserver` profiles on `agent-centos.localdomain`

## Steps:

****

* Install `puppetlabs-mysql` module
* Create a `database` profile for mysql
* Create a `webserver` profile for apache
* Test and apply your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Designing Profiles

****

Create `database` and `webserver` profiles on `agent-centos.localdomain`:

    @@@Sh
    $ puppet module install puppetlabs-mysql

    $ mkdir /home/training/puppet/modules/profiles/{examples,manifests}
    $ cd /home/training/puppet/modules

Create a `database` profile for mysql:

    @@@Sh
    $ vim profiles/manifests/database.pp
    class profiles::database {
      class { '::mysql::server':
        root_password           => 'swordfish',
        remove_default_accounts => true,
      }

      mysql_database { 'information_schema':
        ensure  => present,
        charset => 'utf8',
        collate => 'utf8_general_ci',
      }

      mysql_database { 'mysql':
        ensure  => present,
        charset => 'latin1',
        collate => 'latin1_swedish_ci',
      }

      mysql_database { 'performance_schema':
        ensure  => present,
       charset => 'utf8',
       collate => 'utf8_general_ci',
      }
    }

    $ puppet parser validate profiles/manifests/database.pp
    $ vim profiles/examples/database.pp
    include profiles::database

    $ puppet parser validate profiles/examples/database.pp
    $ sudo puppet apply --noop profiles/examples/database.pp
    $ sudo puppet apply profiles/examples/database.pp

Create a `webserver` profile for apache:

    @@@Sh
    $ vim profiles/manifests/webserver.pp
    class profiles::webserver {
      class { 'apache':
        ensure => running,
        enable => true,
        ssl    => true,
      }
    }

    $ puppet parser validate profiles/manifests/webserver.pp
    $ vim profiles/examples/webserver.pp
    include profiles::webserver

    $ puppet parser validate profiles/examples/webserver.pp

Test and apply your configuration:

    @@@Sh
    $ sudo puppet apply --noop profiles/examples/webserver.pp
    $ sudo puppet apply profiles/examples/webserver.pp
