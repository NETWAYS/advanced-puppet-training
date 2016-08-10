!SLIDE small
# Functions written in Puppet code

    @@@Puppet
    function apache::bool2httpd($arg) {
      case $arg {
        false, undef, /(?i:false)/ : { 'Off' }
        true, /(?i:true)/          : { 'On' }
        default                    : { "$arg" }
      }
    }

* New in Puppet 4
* Always a return value function
* Useable like every builtin or custom function
* Located in a modules subfolder `functions`

~~~SECTION:handouts~~~

****

More on this at: https://docs.puppet.com/puppet/latest/reference/lang_write_functions_in_puppet.html

~~~ENDSECTION~~~

