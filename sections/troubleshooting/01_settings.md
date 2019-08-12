!SLIDE small
# Check Settings (1/3)

Value of one setting:

    @@@Sh
    $ sudo puppet config print <SETTING NAME>

    $ sudo puppet config print masterport
    masterport = 8140

Values of multiple settings:

    @@@Sh
    $ sudo puppet config print <SETTING NAME>
    $ sudo puppet config print <SETTING1> <SETTING2>

    $ sudo puppet config print report reports
    report = true
    reports = store,tagmail

Value of all settings:

    @@@Sh
    $ sudo puppet config print
    ...


!SLIDE small
# Check Settings (2/3)

Values of config sections:

    @@@Sh
    $ sudo puppet config print [--section <CONFIG SECTION>]

    $ sudo puppet config print --section agent
    ...

Valid config sections:

* main (default)
* master
* agent
* use

Specify environment:

    @@@Sh
    $ sudo puppet config print [--environment <ENVIRONMENT>]


!SLIDE small
# Check Settings (3/3)

Alternative syntax:

    @@@Sh
    $ sudo puppet [agent|master] --configprint <SETTING NAME>
    $ sudo puppet agent --configprint ssldir
    /etc/puppetlabs/puppet/ssl

Generate a configuration file including all defaults and explanation:

    @@@Sh
    $ sudo puppet agent --genconfig
    $ sudo puppet agent --genconfig > puppet.conf

~~~SECTION:handouts~~~

****

All these commands are really helpful to verify settings, especially if defaults are
changed from version to version or platform to platform. The "--genconfig" option is
nice for all the explanation helping to find the affecting setting without know its name.

You can furthermore use them for scripting without hardcoded paths.

    @@@Sh
    # rm -rf $(puppet agent --configprint ssldir)

~~~ENDSECTION~~~
