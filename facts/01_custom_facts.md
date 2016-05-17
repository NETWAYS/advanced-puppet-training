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

!SLIDE smbullets small
# Distributing Facts

* Facts are distributed automatically on an agent run if pluginsync is set to true.
* To access a pluginsynced fact on the command line, pass option -p.

<pre>
# puppet agent -t
...
</pre>

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

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Facts

* Objective:
 * Expand your apache module to provide a fact for the apache version
* Steps:
 * Create the fact in lib/facter/apache_version.rb
 * Test the new fact locally
 * Push your code to the master, do an agent run and call facter
