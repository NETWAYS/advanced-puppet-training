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

~~~SECTION:handouts~~~

****

More on Serverspec including a overview of the resource types: http://serverspec.org/

~~~ENDSECTION~~~

!SLIDE small
# Serverspec - Installation

    @@@Sh
    $ gem install serverspec
    $ cd /home/training/puppet/modules/apache
    $ serverspec-init
    Select OS type:

      1) UN*X
      2) Windows

    Select number: 1

    Select a backend type:

      1) SSH
      2) Exec (local)

    Select number: 2

     + spec/
     + spec/localhost/
     + spec/localhost/sample_spec.rb
     + spec/spec_helper.rb


!SLIDE small
# Serverspec - Configuration

    @@@Sh
    $ cd /home/training/puppet/modules/apache
    $ vim spec/localhost/sample_spec.rb
    require 'spec_helper'

    describe package('httpd') do
      it { should be_installed }
    end

    describe service('httpd') do
      it { should be_enabled }
      it { should be_running }
    end

    describe port(80) do
      it { should be_listening }
    end

    describe file('/etc/httpd/conf/httpd.conf') do
      it { should be_file }
      its(:content) { should match /ServerName localhost/ }
    end


!SLIDE small
# Running Tests

    @@@Sh
    $ cd /home/training/puppet/modules/apache
    $ rake spec
    $ ruby -S rspec spec/localhost/httpd_spec.rb
    
    Package "httpd"
      should be installed
    ...
    Finished in 0.098741 seconds
    6 examples, 0 failures


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Write Acceptance Tests
* Objective:
 * Practice designing acceptance tests for the `apache` module
* Steps:
 * Install and configure `serverspec` on `agent-centos.localdomain`
 * Write tests to check the Apache webserver on your local virtual machine
 * Run the acceptance test


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Write Acceptance Tests

## Objective:

****

* Practice designing acceptance tests for the `apache` module

## Steps:

****

* Install and configure `serverspec` on `agent-centos.localdomain`
* Write tests to check the Apache webserver on your local virtual machine
* Run the acceptance test


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Write Acceptance Tests

****

Install and configure `serverspec` on `agent-centos.localdomain`:

    @@@Sh
    training@agent $ gem install serverspec
    training@agent $ cd /home/training/puppet/modules/apache
    training@agent $ mv Rakefile Rakefile.bak
    training@agent $ mv spec spec.bak
    training@agent $ serverspec-init
    Select OS type:

      1) UN*X
      2) Windows

    Select number: 1

    Select a backend type:

      1) SSH
      2) Exec (local)

    Select number: 2

     + spec/
     + spec/localhost/
     + spec/localhost/sample_spec.rb
     + spec/spec_helper.rb

Write tests to check the Apache webserver on your local virtual machine:

    @@@Sh 
    training@agent $ vim spec/localhost/sample_spec.rb
    require 'spec_helper'

    describe package('httpd'), :if => os[:family] == 'redhat' do
      it { should be_installed }
    end

    ...

    describe service('httpd'), :if => os[:family] == 'redhat' do
      it { should be_enabled }
      it { should be_running }
    end

    ...

    describe port(80) do
      it { should be_listening }
    end

~~~PAGEBREAK~~~

Run the acceptance test:

    @@@Sh
    training@agent $ rake spec
    ...
    Package "httpd"
      should be installed

    Service "httpd"
      should be enabled
      should be running

    Port "80"
      should be listening
