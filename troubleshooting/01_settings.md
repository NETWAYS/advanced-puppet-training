!SLIDE small
# Check Settings (1/2)

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
# Check Settings (2/2)

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
