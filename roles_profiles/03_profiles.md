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
 * Designing Profiles
* Steps:
 * Step 1
 * Step 2


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Profiles

## Objective:

****

* Designing Profiles

## Steps:

****

* Step 1
* Step 2


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Designing Profiles

****

Some solution:

    @@@ Sh
    # ...
