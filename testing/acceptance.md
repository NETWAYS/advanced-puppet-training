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
# serverspec-init
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
# cd ~puppetcode/apache
# rake spec
/opt/puppetlabs/puppet/bin/ruby -S rspec
  spec/localhost/httpd_spec.rb
...

Finished in 0.098741 seconds
6 examples, 0 failures
</pre>

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Acceptance Tests

## Objective:

****

* Use acceptance test to validate the result of a puppet agent run.
* Practice designing acceptance tests for the apache module.

## Steps:

****

* Install and configure serverspec.
