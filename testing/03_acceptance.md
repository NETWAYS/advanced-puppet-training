!SLIDE smbullets small
# Acceptance Tests

****

Test the end result

****

* Service installed and running.
* Configuration files:
 * Exists and
 * containing expected settings.
* Listining on correct port.

!SLIDE smbullets small
# Acceptance Tests

****

serverspec: Checks requirements on servers.

****

* Validate local machine.
* SSH to remote server:
 * Uses configured user and sshkey.
 * Also for vagrant boxes.
* Uses native tools.
* Configuration management agnostic.

!SLIDE smbullets small
# Acceptance Tests

*****

serverspec: Installation

****

<pre>
# /opt/puppetlabs/puppet/bin/gem install serverspec
# cd ~puppetcode/apache
# mkdir serverspec
# cd serverspec
# /opt/puppetlabs/puppet/bin/serverspec-init
</pre>

!SLIDE smbullets small
# Acceptance Tests

*****

serverspec: Configuration

****

<pre>
# vim spec/localhost/httpd_spec.rb
require 'spec_helper'

describe package('httpd') do
  if { should be_installed }
end

describe service('httpd') do
  it { should be_enable }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

decribe file('/etc/httpd/conf/httpd.conf') do
  it { should be_file }
  its(:content) { should match /ServerName localost/ }
end
</pre>

!SLIDE smbullets small
# Acceptance Tests

*****

Running tests

****

<pre>
# cd ~puppetcode/apache/serverspec
# /opt/puppetlabs/puppet/bin/rake spec
/opt/puppetlabs/puppet/bin/ruby -S rspec
  spec/localhost/httpd_spec.rb
...

Finished in 0.098741 seconds
6 examples, 0 failures
</pre>


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Acceptance Tests

* Objective
 * Practice designing acceptance tests for the apache module.


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

## Objective:

* Practice designing acceptance tests for the apache module.

## Steps:

* Install and configure serverspec.
* Write tests to check the apache webserver on your local virtual machine.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

****

## Practice designing acceptance tests for the apache module

****

### Install and configure serverspec

* Create a directory serverspec and change into it.
<pre>
# mkdir ~/serverspec
# cd ~/serverspec
</pre>

* Initialize the acceptance test environment.
<pre>
# /opt/puppetlabs/puppet/bin/serverspec-init
Select OS type:

  1) UN*X
  2) Windows

Select number: 1

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Vagrant instance y/n: n
Input target host name: centos7.localdomain
</pre>

### Write tests to check the apache webserver on your local virtual machine

* Write tests to check, i.e. the package is installed, service is running and listen on port 80.
<pre>
# vim spec/centos7.localdomain
require 'spec_helper'

describe package('httpd'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end
</pre>

* Run the acceptance test.
<pre>
# /opt/puppetlabs/puppet/bin/rake spec
...
ackage "httpd"
  should be installed

Service "httpd"
  should be enabled
  should be running

Port "80"
  should be listening

Finished in 0.13169 seconds (files took 4.63 seconds to load)
4 examples, 0 failures
</pre>
