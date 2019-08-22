!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

* Objective:
 * Rebuild `bool2httpd.rb` in puppet language.
* Steps:
 * Create the function in `bool2httpd.pp`
 * Test the new function with `puppet apply`


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

## Objective:

****

* Rebuild `bool2httpd.rb` in puppet language.

## Steps:

****

* Change into the modules directory
* Create the function in `apache/functions/bool2httpd.pp`
* Test the new function with `puppet apply`


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

****

## Add a function `bool2httpd` to your apache module

****

Create the function in `apache/lib/puppet/functions/bool2httpd.rb`:

    @@@Sh
    training@puppet $ mkdir -p /home/training/puppet/modules/apache/functions
    training@puppet $ cd /home/training/puppet/modules
    training@puppet $ vim apache/functions/bool2httpd.pp
    function apache::bool2httpd(Variant[String, Boolean] $arg) >> String {
      case $arg {
        false, undef, /(?i:false)/ : { 'Off' }
        true, /(?i:true)/          : { 'On' }
        default                    : { "$arg" }
      }
    }
    
Test the new function with `puppet apply`:

    @@@ Sh
    training@puppet $ puppet apply -e 'notice(apache::bool2httpd(false))'
    Notice: Scope(Class[main]): Off

    training@puppet $ puppet apply -e 'notice(apache::bool2httpd(true))'
    Notice: Scope(Class[main]): On
