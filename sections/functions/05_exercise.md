!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

* Objective:
 * Add a function `bool2httpd` to your apache module
 * Returns a string `On` if argument is true, `Off` for false and otherwise returns the argument itself
* Steps:
 * Create the function in `bool2httpd.rb`
 * Test the new function with `puppet apply`


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

## Objective:

****

* Add a function `bool2httpd` to your apache module
* Returns a string `On` if argument is true, `Off` for false and otherwise returns the argument itself

## Steps:

****

* Change into the modules directory
* Create the function in `apache/lib/puppet/parser/functions/bool2httpd.rb`
* Test the new function with `puppet apply`


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

****

## Add a function `bool2httpd` to your apache module

****

Create the function in `apache/lib/puppet/functions/bool2httpd.rb`:

    @@@Sh
    training@puppet $ mkdir -p /home/training/puppet/modules/apache/lib/puppet/parser/functions
    training@puppet $ cd /home/training/puppet/modules
    training@puppet $ vim apache/lib/puppet/parser/functions/bool2httpd.rb
    Puppet::Functions.create_function(:bool2httpd) do
      dispatch :bool2httpd do
        param 'Variant[String,Array,Hash,Boolean]', :value
      end
      def bool2httpd(values)
        if values.size != 1
          raise ArgumentError, 'bool2httpd() wrong number of arguments.'
        end
  
        value = values[0]
  
        if value.nil? or value == false or value =~ /false/i or value == :undef
          return 'Off'
        elsif value == true or value =~ /true/i
          return 'On'
        end
        return value.to_s
      end
    end
  


Test the new function with `puppet apply`:

    @@@ Sh
    training@puppet $ puppet apply -e 'notice(bool2httpd(false))'
    Notice: Scope(Class[main]): Off

    training@puppet $ puppet apply -e 'notice(bool2httpd(true))'
    Notice: Scope(Class[main]): On
