!SLIDE noprint
# Managing devices

Running the `puppet device` or `puppet-device` command (without `--resource` or `--apply` options) tells the proxy agent to retrieve catalogs from the master and apply them to the remote devices listed in the `device.conf` file.

    @@@Sh
    sudo puppet device


To set up a cron job to run Puppet device on a recurring schedule, run: 

    @@@Sh
    sudo puppet resource cron puppet-device ensure=present user=root minute=30 command='/opt/puppetlabs/bin/puppet device --verbose --logdest syslog'


!SLIDE smbullets noprint
# Managing devices

Useful parameters include:

* `--verbose`
* `--resource`
* `--apply`
* `--target`
  * which lets you specify a device to run puppet on from your `device.conf`
* `--deviceconfig`
  * to specify another path
