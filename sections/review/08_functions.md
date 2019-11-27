!SLIDE smbullets small
# Functions

    @@@Puppet
    class apache::params {
      case $facts['os']['family'] {
      ...
        default: {
         fail('Your operatingsystem is not supported, yet.')
        }
      }
    }

* Always executed on the Master during Catalog Compilation
* Two types:
 * **Statement** - Executes an action and does not return arguments (fail, notice, etc.)
 * **rvalue** - Returns a value (template, versioncmp, etc.)
