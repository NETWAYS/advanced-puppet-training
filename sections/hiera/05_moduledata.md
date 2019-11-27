!SLIDE small
# Module data instead of params.pp

* params.pp does nothing but set variables for the other classes
* A params can easily get overwhelming and complicated based on the amount of variables set

Way easier to maintain is the approach of adding hiera data to an existing module.

!SLIDE small
# Module data

`manifests/init.pp`

    @@@Puppet
    class apache (
      $apache_package, 
      $apache_configdir
     ...
    ) {
     ...
    }

`data/Debian.yaml`

    @@@Sh
    ---
    apache::apache_package: apache2
    apache::apache_configdir: /etc/apache2



!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera

* Objective:
 * Replace params.pp with module data
* Steps:
 * Change params inheritance
 * Create module data in `Debian.yaml` and `RedHat.yaml`
 * Use `puppet apply`


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Use Hiera (version 3)

## Objective:

****

* Replace params.pp with module data

## Steps:

****

* Objective:
 * Replace params.pp with module data
* Steps:
 * Change params inheritance
 * Create module data in `Debian.yaml` and `RedHat.yaml`
 * Use `puppet apply`

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Use Hiera

****

Change params inheritance:

    class apache (
     ...
    $apache_package,
    $configdir,
    $apache_config,
    $apache_service,
    $ssl
    ) {
     ...
    }

Create and lookup hierarchy for environment production:

    training@puppet $ vim data/RedHat.yaml
    ---
    apache::apache_package: httpd
    apache::configdir: /etc/httpd
    apache::apache_config: "%{lookup('apache::configdir')}/conf/httpd.conf”
    apache::apache_service: httpd
    apache::ssl: true

    training@puppet $ vim data/Debian.yaml
    ---
    apache::apache_package: apache2
    apache::configdir: /etc/apache2
    apache::apache_config: "%{lookup('apache::configdir')}/apache2.conf"
    apache::apache_service: apache2
    apache::ssl: false

Use `puppet apply`:

    @@@Sh
    training@puppet $ sudo puppet apply examples/init.pp 
