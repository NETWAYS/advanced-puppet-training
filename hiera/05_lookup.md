!SLIDE small
# lookup Function

* Returns the first value found by default
* Configure it to merge multiple values into one
* Replaces `hiera`, `hiera_array`, and `hiera_hash` functions of Hiera 3


!SLIDE small
# lookup Function Syntax

    lookup( <NAME>, [<VALUE TYPE>], [<MERGE BEHAVIOR>], \
      [<DEFAULT VALUE>] )

Look up a key and return the first value found:

    lookup('ntp::service_name')

Do a unique merge lookup of class names, then add all of those classes to the catalog (like `hiera_include`):

    lookup('classes', Array[String], 'unique').include

Do a deep hash merge lookup of user data, but let higher priority sources remove values by prefixing them with "--":

    lookup( { 'name' => 'users',
          'merge' => {
            'strategy'        => 'deep',
            'knockout_prefix' => '--',
          },
    })
