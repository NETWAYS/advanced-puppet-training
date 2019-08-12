!SLIDE small
# Config Version in Reports

* `config_version` can be generated programatically
* This setting is per-environment and there is no global override
* Correlates reports to version of Puppet codebase

<pre>
$environmentpath/production/environment.conf
config_version = /bin/date
</pre>

* Can be integrated with version control to display latest commit

<pre>
$environmentpath/development/environment.conf
config_version = /usr/local/bin/return_git_version

info: Caching catalog for agent.puppetlabs.vm
info: Applying configuration version '5d4bdb7'
notice: Finished catalog run in 2.95 seconds
</pre>
