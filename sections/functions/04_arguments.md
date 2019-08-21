!SLIDE small
# Handling Arguments

    @@@Ruby
    $ cat {MODULE NAME}/lib/puppet/parser/functions/basename.rb
    Puppet::Functions.create_function(:basename)  do
      dispatch :basename do
        param 'Variant[String,Array,Hash]', :value
      end
      def basename(value)
        if value.is_a?(String)
          result = "true"
        else
          raise ArgumentError, 'Expected a string!'
        end
        result
      end
    end

* We must accept arguments, even if we do not use them
* Arguments are passed as a single array

~~~SECTION:handouts~~~

****

The code on this page is the long form version of the following code, which is more like the code sample from the previous page.

    @@@Ruby
    Puppet::Functions.create_function(:basename)  do
      dispatch :basename do
        param 'Variant[String,Array,Hash]', :value
      end
      def basename(value)
        if value.is_a?(String)
          result = "true"
        else
          raise ArgumentError, 'Expected a string!'
        end
        result
      end
    end

~~~ENDSECTION~~~
