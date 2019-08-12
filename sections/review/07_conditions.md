!SLIDE smbullets
# Conditional Statements

* Selectors
* `"Case"` statements
* `"If"` statements
* `"Unless"` statements

~~~SECTION:handouts~~~

****

Selectors are a conditional to set a value for an attribute or variable depending on another already defined variable (in many cases a fact).

A `"Case"` statement can be used to set any number of variables or provide alternative Puppet code depending of the value of a variable.

`"If"` and `"Unless"` statements are used to alternate based on conditions which can be simple value comparision to complex functions.

~~~ENDSECTION~~~

!SLIDE small
# Case Statement

    @@@ Puppet
    class apache::params {
       case $::osfamily {
        'RedHat': {
          $package = 'httpd'
          $config  = '/etc/httpd/conf/httpd.conf'
          $service = 'httpd'
        }
        'Debian': {
          $package = 'apache2'
          $config  = '/etc/apache2/apache2.conf'
          $service = 'apache2'
        }
      }
    }
