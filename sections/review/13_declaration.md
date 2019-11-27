!SLIDE small
# Declaration

Default:

    @@@Puppet
    include apache
    # or
    class { 'apache': }

Parameterized Class:

    @@@Puppet
    class { 'apache':
      ensure => running,
      ssl    => true,
    }

Defined Resource Type:

    @@@Puppet
    apache::vhost { 'training.netways.de':
      ensure  => present,
      docroot => '/var/www/training',
    }


!SLIDE smbullets small
# Puppet Apply Command

    @@@Puppet
    $ sudo puppet apply --noop apache/examples/init.pp
    Notice: /Stage[main]/Apache/Package[httpd]/ensure:
     current_value absent, should be present (noop)
    ...
    Notice: Finished catalog run in 0.20 seconds

    $ sudo puppet apply apache/examples/init.pp
    Notice: /Stage[main]/Apache/Package[httpd]/ensure: created
    Notice: /Stage[main]/Apache/Service[httpd]/ensure:
      ensure changed 'stopped' to 'running'
    Notice: Finished catalog run in 8.94 seconds

* The Puppet apply command combines master and agent functionality
 * Takes a file containing Puppet code
 * Gathers information using Facter
 * Compiles a catalog
 * Enforces the configuration
 * Can also run in simulation mode
* Useful for development and local testing or master-less setups

~~~SECTION:handouts~~~

~~~PAGEBREAK~~~

The Puppet apply command combines master and agent functionality which is useful for development
and local testing or master-less setups.

It takes a file containing Puppet code as input, then gathers information about the system using
Vacter to compile a catalog and last but not least enforces the configuration. It can also run in
simulation mode which only notifies about required changes instead of enforcing it.

To reduce complexity for now we will start developing Puppet code and use apply to test it and only
move later to a master agent setup.

~~~ENDSECTION~~~
