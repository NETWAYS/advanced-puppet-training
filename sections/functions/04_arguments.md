!SLIDE small
# Handling Arguments

    @@@Ruby
    $ cat {MODULE NAME}/lib/puppet/parser/functions/basename.rb
    module Puppet::Parser::Functions
      newfunction(:basename,
        :type   => :rvalue,
        :arbity => 1
      ) do |args|
        raise ArgumentError, 'Expected a string!' \
          unless args.first.class == String

        filename = args[0]
        File.basename filename
      end
    end

* We must accept arguments, even if we do not use them
* Arguments are passed as a single array

~~~SECTION:handouts~~~

****

The code on this page is the long form version of the following code, which is more like the code sample from the previous page.

    @@@Ruby
    Puppet::Parser::Functions.newfunction(
      :basename,
      :type   => :rvalue,
      :arbity => 1
    ) do |args|
      raise ArgumentError, 'Expected a string!' \
        unless args.first.class == String

      filename = args[0]
      File.basename filename
    end
~~~ENDSECTION~~~
