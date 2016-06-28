!SLIDE small
# Check Settings (1/3)

Value of one setting:

    @@@ Sh
    # puppet config print <SETTING NAME>

    # puppet config print masterport
    masterport = 8140

Values of multiple settings:

    @@@ Sh
    # puppet config print <SETTING NAME>
    # puppet config print <SETTING1> <SETTING2>

    # puppet config print report reports
    report = true
    reports = store,tagmail

Value of all settings:

    @@@ Sh
    # puppet config print
    ...


!SLIDE small
# Check Settings (2/3)

Values of config sections:

    @@@ Sh
    # puppet config print [--section <CONFIG SECTION>]

    # puppet config print --section agent
    ...

Valid config sections:

* main (default)
* master
* agent
* use

Specify environment:

    @@@ Sh
    # puppet config print [--environment <ENVIRONMENT>]

!SLIDE small
# Check Settings (2/3)

Alternative syntax:

    @@@ Sh
    # puppet [agent|master] --configprint <SETTING NAME>
    # puppet agent --configprint ssldir
    /etc/puppetlabs/puppet/ssl

Generate a configuration file including all defaults and explanation:

    @@@ Sh
    # puppet agent --genconfig
    # puppet agent --genconfig > /etc/puppetlabs/puppet/puppet.conf

~~~SECTION:handouts~~~

****

All these commands are really helpful to verify settings, especially if defaults are
changed from version to version or platform to platform. The "--genconfig" option is
nice for all the explanation helping to find the affecting setting without know its name.

You can furthermore use them for scripting without hardcoded paths.

    @@@ Sh
    # rm -rf $(puppet agent --configprint ssldir)

~~~ENDSECTION~~~
