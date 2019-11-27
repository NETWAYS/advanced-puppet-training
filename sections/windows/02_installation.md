!SLIDE smbullets noprint

# Windows Installation using the installer

* Download the according .msi from http://downloads.puppetlabs.com/windows/
* Run the installer as administrator
* When prompted, provide the hostname of your master, for example puppet

This way of installing puppet for windows will use the `masterport` 8140 for https traffic
and run the puppet agent as the `LocalSystem` User. Using the `LocalSystem` User prevents puppet from accessing UNC shares.

!SLIDE smbullets noprint

# Windows Installation using msiexec (recommended)

* Run the install command: `msiexec /qn /norestart /i <PACKAGE_NAME>.msi`
* You can specify `/l*v install.txt` to log the progress of the installation to a file

By default puppet will again be run as `LocalSystem` user, to change that we can set the following properties: `PUPPET_AGENT_ACCOUNT_USER`, `PUPPET_AGENT_ACCOUNT_PASSWORD`, and `PUPPET_AGENT_ACCOUNT_DOMAIN`. 


The command could look somewhat like this:

`msiexec /qn /norestart /i puppet.msi PUPPET_AGENT_ACCOUNT_USER=training PUPPET_AGENT_ACCOUNT_PASSWORD=awesome`


!SLIDE noprint

# More msiexec installation properties

* `INSTALLDIR`
  * Location to install Puppet and its dependencies.
* `PUPPET_MASTER_SERVER`
  * Hostname where the master can be reached. 
* `PUPPET_AGENT_CERTNAME`
  * Node's certificate name, and the name it uses when requesting catalogs.

All MSI properties can be found here: https://puppet.com/docs/puppet/6.0/install_agents.html#msi-properties
