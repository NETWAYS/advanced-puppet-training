!SLIDE smbullets small
# Accessing Facts

* Facts are exposed as top scope variables.
* Fact variable should always contain a top scope reference.

<pre>
class system {
  $operatingsystem = 'OzzyOS'
  notify { "Your operartingsystem is: ${::operatingsystem}" }
}

notice: Your operatingsystem is: CentOS
</pre>

<pre>
class system {
  $operatingsystem = 'OzzyOS'
  notify { "Your operartingsystem is: ${operatingsystem}" }
}

notice: Your operatingsystem is: OzzyOS
</pre>

!SLIDE smbullets small
# Developing Facts

* By convention, the file name has to match the name of the fact.
* Multiple facts can be contained by a single module.

<pre>
# tree /opt/puppetlabs/puppet/modules/custom
|-- lib
|   |-- facter
|   |   `-- role.rb
</pre>

* Test facts locally by setting FACTERLIB or RUBYLIB environment variables.

<pre>
# export RUBYLIB=/opt/puppetlabs/puppet/modules/custom/lib
# facter role
Apache Webserver
</pre>

!SLIDE smbullets small
# Custom Facts

* The fact is set to the string value returned from setcode block. With facter 2.0 or higher array and hash also permitted as return value.

<pre>
# role.rb
Facter.add('role') do
  setcode do
    role = Facter::Core::Execution.exec('cat /etc/role')
    role.gsub(/<.*?>/m, "")
  end
end
</pre>

* If on a string no other manipulation is needed you can pass the string to setcode.

<pre>
# role.rb
Facter.add('role') do
  setcode 'cat /etc/role'
end
</pre>

~~~SECTION:handouts~~~

****

setcode will accept a Ruby block or a single shell command as a string. For example, you could implement first fact concisely in pure Ruby like so:

<pre>
# role.rb
Facter.add('role') do
  setcode do
    File.read('/etc/role').gsub(/<.*?>/m, "")
  end
end
</pre>

Note that older versions of Facter exposed a method called Facter::Util::Resultion.exec. This has been deprecated and currently redirects to the Facter::Core::Execution.exec you see in the example.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Distributing Facts

* Facts are distributed automatically on an agent run if pluginsync is set to true.
* To access a pluginsynced fact on the command line, pass option -p.

<pre>
# puppet agent -t
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/role.rb]/ensure: defined content as '{md5}6f5231ef17747dc73e619970ca654998'
Info: Loading facts
...
Notice: Applied catalog in 0.03 seconds
</pre>

~~~SECTION:handouts~~~

****

Notice that the Puppet agent run first downloads any new or changed facts and then loads them. This precedes the catalog request and application. The practical implications of this are that custom facts are available for use on the very first Puppet agent run after they are defined. You do not need to sync them on one Puppet run and then use them on the next unless they depend on resources that are managed by Puppet itself.

You can force a pluginsync without a Puppet run with puppet plugin download.

If a fact is synced via pluginsync, then the version of the fact that was synced will take precedence over a fact tested by setting FACTERLIB. For this reason, it is often useful to stop the Puppet agent before commencing development so that an incomplete fact doesn't get synced.

As of Puppet 3.0, the RUBYLIB or FACTERLIB environment variable must be fully qualified.

~~~ENDSECTION~~~

!SLIDE smbullets small
# External Facts
* Could be yaml, json, text files or executable scripts

<pre>
# cat /opt/puppetlabs/facter/facts.d/datacenter.yaml
---
location: nuremberg
cluster: webserver
</pre>

<pre>
# cat /opt/puppetlabs/facter/facts.d/datacenter.txt
location=nuremberg
cluster=webserver
</pre>

<pre>
# facter location
nuremberg
</pre>

* Also distributed via pluginsync from $module/facts.d

~~~SECTION:handouts~~~

****

As of Puppet 3.4 and Facter 2.0.1, external facts are now pluginsynced like any other custom fact. This makes distributing these facts much simpler. External facts should be located in the module's facts.d directory, and they'll automatically synced on each Puppet run.

External facts will also execute scripts in the external fact path with the execute bit set. For Facter to parse the output, the script must echo key/value pairs on stdout in the format:

key1=value1
key2=value2

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Facts

* Objective:
 * Expand your apache module to provide a fact for the apache version.
* Steps:
 * Create the fact in lib/facter/apache_version.rb.
 * Test the new fact locally.
 * Push your code to the master, do an agent run and call facter.

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Facts

## Objective:

****

* Expand your apache module to provide a fact for the apache version.

## Steps:

****

* Create the fact in lib/facter/apache_version.rb:
 * Use a command line with apachectl and sed,
 * optional: Build the same fact in ruby.

'apachectl -v 2>&1|sed -n "s|^Server version:\s*Apache/\([0-9]\\+.[0-9]\\+.[0-9]\\+\).*$|\1|p"'

* Test the new fact locally.
* Push your code to the master, do an agent run and call facter.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Facts

****

## Expand your apache module to provide a fact for the apache version

****

### Use a command line with apachectl and sed

* Change into your apache directory

<pre>
# cd ~/puppetcode/modules
</pre>

* Create the subdirectory structure for custom facts

<pre>
# mkdir -p ./apache/lib/facter
</pre>

* Create a new ruby file ./apache/lib/facter/apache_version.rb

<pre>
Facter.add(:apache_version) do
  setcode 'apachectl -v 2>&1 | \
    sed -n "s|^Server version:\s*Apache/\([0-9]\\+.[0-9]\\+.[0-9]\\+\).*$|\1|p"
end
</pre>

### Test your code locally

* Change into your module directory

<pre>
# cd ~/puppetcode/modules
</pre>

* Check the syntax of the ruby file

<pre>
# ruby -c ./apache/lib/facter/apache_version.rb
Syntax OK
</pre>

* Call facter by setting the RUBYLIB environment variable:

<pre>
# RUBYLIB=$PWD/apache/lib facter apache_version
2.4.6
</pre>

### Optional: Build the same fact in ruby

* New content of ./apache/lib/facter/apache_version.rb

<pre>
Facter.add(:apache_version) do
  setcode do
    if Facter::Util::Resolution.which('apachectl')
      apache_version = Facter::Util::Resolution.exec('apachectl -v 2>&1')
      %r{^Server version: Apache\/([\w\.]+) \(([\w ]*)\)}.match(apache_version)[1]
    end
  end
end
</pre>
