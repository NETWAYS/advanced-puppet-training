!SLIDE smbullets small
# Adding Functionality to the Language

* Functions are evulated during compalation.
* From this it follows that they are evaluated on the master.
* Commonly used for:
 * interfacing with external tools
 * expand additional functionality to the Puppet DSL

* Example functions:
 * include
 * template
 * str2bool

!SLIDE smbullets small
# Types of Functions

* :statement
 * Code is evaluated on compilation.
 * Perform an action like output or log information.
 * This is the default.

* :rvalue
 * Also evaluated on compilation, but return a value.
 * The return value can be used for:
  * Assigned to a variable.
  * Assigned to a resource parameter.
  * Used to chose a conditional branch.

!SLIDE smbullets small
# Functions are Provided by a Puppet Module.

* The code consists of ruby code.
* The name of the function and the filename must match.

<pre>
# tree /opt/puppetlabs/puppet/modules/custom
 |-- lib
 |   `-- puppet
 |       `-- parser
 |           `-- functions
 |               `-- myfunc.rb
</pre>

!SLIDE smbullets small
# Adding a Function

* A custom :statement function:

<pre>
Puppet::Parser::Functions.newfunction(:myfunc) do |args|
  ...
end
</pre>

* A custom :rvalue function:

<pre>
Puppet::Parser::Functions.newfunction(:myfunc), \
  type => :rvalue do |args|
  ...
end
</pre>

!SLIDE smbullets small
# Handling Arguments

* We must accept arguments, even if we do not use them.
* Arguments are passed as a single array.

<pre>
# basename.rb
module Puppet::Parser::Functions
  newfunction(:basename,
    :type   => :rvalue,
    :arbity => 1
  ) do |args|
    raise ArgumentError,
      'Expected a string!' unless args.first.class == String

    filename = args[0]
    File.basename filename
  end
end
</pre>

~~~SECTION:handouts~~~

****

The code on this page is the long form version of the following code, which is more like the code sample from the previous page.

<pre>
Puppet::Parser::Functions.newfunction(
  :basename,
  :type   => :rvalue,
  :arbity => 1
) do |args|
  raise ArgumentError,
    'Expected a string!' unless args.first.class == String

  filename = args[0]
  File.basename filename
end
</pre>

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

* Objective:
 * Add a function bool2httpd to your apache module.
 * Returns a string On if argument is true, Off for false and otherwise returns the argument itself.
* Steps:
 * Create the function in bool2httpd.rb.
 * Test the new function with a puppet apply.


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

## Objective:

****

* Add a function bool2httpd to your apache module.
* Returns a string On if argument is true, Off for false and otherwise returns the argument itself.

## Steps:

****

* Change into the modules directory.
* Create the function in apache/lib/puppet/parser/functions/bool2httpd.rb.
* Test the new function with a puppet apply.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Function

****

## Add a function bool2httpd to your apache module

****

* Change into the modules directory.

<pre>
# cd ~/puppetcode/modules
</pre>

* Create the function in apache/lib/puppet/parser/functions/bool2httpd.rb.

<pre>
Puppet::Parser::Functions::newfunction(
  :bool2httpd,
  :type   => :rvalue,
  :arbity => 1
) do |args|
  raise ArgumentError,
    'bool2httpd() wrong number of arguments.') if args.size != 1

  arg = args[0]

  if arg.nil? or arg == false or arg =~ /false/i or arg == :undef
    return 'Off'
  elsif arg == true or arg =~ /true/i
    return 'On'
  end

  return arg.to_s
end
</pre>

* Test the new function with a puppet apply.

<pre>
# puppet apply -e 'notice(bool2httpd(false))'
Notice: Scope(Class[main]): Off
Notice: Compiled catalog for ...
Notice: Applied catalog in 0.02 seconds
</pre>

