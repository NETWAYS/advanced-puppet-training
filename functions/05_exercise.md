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

Change into the modules directory:

    @@@ Sh
    # cd ~/puppetcode/modules

Create the function in `apache/lib/puppet/parser/functions/bool2httpd.rb`:

    @@@ Ruby
    Puppet::Parser::Functions::newfunction(
      :bool2httpd,
      :type   => :rvalue,
      :arbity => 1
    ) do |args|
      raise ArgumentError, 'bool2httpd() wrong number of arguments.') if args.size != 1

      arg = args[0]

      if arg.nil? or arg == false or arg =~ /false/i or arg == :undef
        return 'Off'
      elsif arg == true or arg =~ /true/i
        return 'On'
      end

      return arg.to_s
    end

Test the new function with `puppet apply`:

    @@@ Sh
    # puppet apply -e 'notice(bool2httpd(false))'
    Notice: Scope(Class[main]): Off
    Notice: Compiled catalog for ...
    Notice: Applied catalog in 0.02 seconds
