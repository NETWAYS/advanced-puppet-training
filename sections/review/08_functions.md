!SLIDE smbullets small
# Functions

    @@@Puppet
    class apache::params {
      case $::osfamily {
      ...
        default: {
         fail('Your operatingsystem is not supported, yet.')
        }
      }
    }

* Always executed on the Master during Catalog Compilation
* Two types:
 * **Statement** - Executes an action and do not return arguments (fail, notice, etc.)
 * **rvalue** - Returns a value (template, versioncmp, etc.)
