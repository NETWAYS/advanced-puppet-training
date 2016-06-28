!SLIDE small
# Distributing Facts

    @@@ Puppet
    # puppet agent -t
    Info: Using configured environment 'production'
    Info: Retrieving pluginfacts
    Info: Retrieving plugin
    Notice: /File[/opt/puppet/cache/lib/facter]/ensure: created
    Notice: /File[/opt/puppet/cache/lib/facter/role.rb]/ensure:\
      defined content as '{md5}6f5231ef17747dc73e619970ca654998'
    Info: Loading facts
    ...
    Notice: Applied catalog in 0.03 seconds

* Facts are distributed automatically on an agent run if `pluginsync` is set to "true"
* To access a pluginsynced fact on the command line
 * use `puppet facts` 
 * pass option "-p" to `facter`

~~~SECTION:handouts~~~

****

Notice that the Puppet agent run first downloads any new or changed facts and then loads them. This precedes the catalog request and application. The practical implications of this are that custom facts are available for use on the very first Puppet agent run after they are defined. You do not need to sync them on one Puppet run and then use them on the next unless they depend on resources that are managed by Puppet itself.

You can force a pluginsync without a Puppet run with `puppet plugin download`.

If a fact is synced via pluginsync, then the version of the fact that was synced will take precedence over a fact tested by setting FACTERLIB. For this reason, it is often useful to stop the Puppet agent before commencing development so that an incomplete fact doesn't get synced.

As of Puppet 3.0, the RUBYLIB or FACTERLIB environment variable must be fully qualified.

~~~ENDSECTION~~~
