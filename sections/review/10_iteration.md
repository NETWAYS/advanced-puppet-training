!SLIDE smbullets small
# Iteration

    @@@ Puppet
    $binaries = ["facter", "hiera", "mco", "puppet"]

    $binaries.each |String $binary| {
      file {"/usr/bin/$binary":
        ensure => link,
        target => "/opt/puppetlabs/bin/$binary",
      }
    }

* Introduced with Puppet 4
* Different iteration functions 
 * **each** - repeat a code block for each object
 * **slice** - repeat a code block a given number of times
 * **filter** - remove non-matching elements
 * **map** - transform values to some data structure
 * **reduce** - combine values to a new data structure
 * **with** - create a private code block (no real iteration)
