!SLIDE subsectionnonum
# Acceptance Tests


!SLIDE smbullets
# Acceptance Test

Test the end result:

* Service installed and running
* Configuration files:
 * Exists
 * Containing expected settings
* Listening on correct port


!SLIDE smbullets
# Serverspec

Checks requirements on servers:

* Validate local machine
* SSH to remote server:
 * Uses configured user and sshkey
 * Also for Vagrant boxes
* Uses native tools
* Configuration management agnostic


!SLIDE small
# Serverspec - Installation

    @@@ Sh
    # gem install serverspec
    # cd /etc/puppet/modules/apache/
    # mkdir serverspec
    # cd serverspec/
    # serverspec-init


!SLIDE small
# Serverspec - Configuration

    @@@ Ruby
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


!SLIDE small
# Running Tests

    @@@ Sh
    # cd /etc/puppet/modules/apache/serverspec/
    # rake spec
    # ruby -S rspec spec/localhost/httpd_spec.rb
    ...
    Finished in 0.098741 seconds
    6 examples, 0 failures


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Write Acceptance Tests
* Objective:
 * Practice designing acceptance tests for the `apache` module
* Steps:
 * Install and configure `serverspec`
 * Write tests to check the Apache webserver on your local virtual machine
 * Run the acceptance test

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Write Acceptance Tests

## Objective:

* Practice designing acceptance tests for the `apache` module

## Steps:

* Install and configure `serverspec`
* Write tests to check the Apache webserver on your local virtual machine
* Run the acceptance test


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Practice designing acceptance tests for the `apache` module

****

Install and configure `serverspec`:

    @@@ Sh
    # mkdir ~/serverspec
    # cd ~/serverspec

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

Write tests to check the Apache webserver on your local virtual machine:

    @@@ Ruby
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

Run the acceptance test:

    @@@ Sh
    # rake spec
    ...
    Package "httpd"
      should be installed

    Service "httpd"
      should be enabled
      should be running

    Port "80"
      should be listening

    Finished in 0.13169 seconds (files took 4.63 seconds to load)
    4 examples, 0 failures
