!SLIDE noprint
# Logging on Windows

* To activate logging you either run the following command to create a required registry key:
  * `reg add HKLM\System\CurrentControlSet\Services\EventLog\Puppet\Puppet /v EventMessageFile /t REG_EXPAND_SZ /d "C:\Program Files\Puppet Labs\Puppet\bin\puppetres.dll"`
* Or you use this powershell cmdlet to achieve the same outcome:
  * `New-EventLog -Source Puppet -LogName Puppet -MessageResource "C:\Program Files\Puppet Labs\Puppet\bin\puppetres.dll"`

You can adjust how verbose the logs are with the `log_level` setting, which defaults to `notice`.

When running in the foreground with the `--verbose`, `--debug`, or `--test` options, Puppet agent logs directly to the terminal.

When started with the `--logdest <FILE>` option, Puppet agent logs to the file specified by `<FILE>`.
