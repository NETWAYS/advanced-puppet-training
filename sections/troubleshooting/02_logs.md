!SLIDE smbullets
# Logs

* Default:
 * Logs to syslog
 * Facility *daemon*
 * Loglevel *notice*
* Possible changes:
 * Increase `log_level` for more detailed output
 * Change the config setting `logdest` to either `syslog`, `eventlog`, `console` or the path to a log file
 * Add `show_diff` to see file changes in logfile

~~~SECTION:handouts~~~

****

Best strategy is to use Puppet's reporting capabilities to get information about all Puppet agent
runs in one place. But if a system fails to send reports you can use local logging for debugging.

By default the Puppet agent logs to syslog using the facility *daemon* and a loglevel *notice*
which results in quite many messages going to '/var/log/messages' or '/var/log/daemon' depending
of the distribution or to the event log if used on Windows.

~~~PAGEBREAK~~~

For debugging you can increase the `log_level` to get even more details in the log. *info* is
the same you get when running the agent in verbose mode and *debug* corresponds the debug mode.
By changing the facility to one of the local ones you can move the log messages to a seperate file. You can specify that file via the config setting `logdest` which can be either `syslog`, `eventlog`, `console` or the path to a log file.

By setting `show_diff` to *true* you can get all file changes in detail logged.

~~~ENDSECTION~~~
