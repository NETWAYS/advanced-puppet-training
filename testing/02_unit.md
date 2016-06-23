!SLIDE subsectionnonum
# Unit Tests


!SLIDE small
# What Should You be Testing?

* Unit tests do not test the result on a live system
* Test the behaviour of Puppet catalog compilations to:
 * Ensure that resources are included
 * Ensure that classes are declared
 * Validate resource attributes
 * Evaluate with different class parameters


!SLIDE smbullets small
# RSpec Tests for Puppet Manifests

    @@@ Ruby
    require 'spec_helper'

    describe('apache', :type => :class) do
      let(:node) { 'agent-centos.localdomain' }

      describe 'when call without parameters on redhat' do
        let(:facts) { {:osfamily => 'RedHat'} }

        it {
          should contain_file('/etc/httpd/conf/httpd.conf').with({
            'ensure' => 'file',
            'owner'  => 'root',
          }).with_content(/^ServerName #{node}.*$/)
        }
      end
    end


!SLIDE small
# Running Tests

    @@@ Ruby
    # /opt/puppetlabs/puppet/bin/rake spec
    /opt/puppetlabs/puppet/bin/ruby
      -S rspec spec/classes/motd_spec.rb --color
    ...

    Finished in 0.14713 seconds 1 example, 0 failures

~~~SECTION:handouts~~~

****

To get a quick overview of the http://puppet.com/tutorial/. This will teach you how to write simple unit tests for your modules and might be all you ever need to read.

Remember that you do not need to run rspec-puppet-init when using puppetlabs_spec_helper.

~~~ENDSECTION~~~


!SLIDE small
# RSpec Matchers

Validate successful catalog compilation:

    @@@ Sh
    it {should compile}

Validate the catolog contains resources:

    @@@ Sh
    contain_{resource type}

Validate that resources have specified attributes:

    @@@ Sh
    with_{attribute}
    without_{attribute}

Validate thate resources have relationships set:

    @@@ Sh
    that_{relationship}

Shortcut helpers combine matchers:

    @@@ Sh
    with, without

~~~SECTION:handouts~~~

****

RSpec matchers can match exact values, regular expressions, or Ruby Procs. You can see example usages for many matchers in the code sample on the following page.

    @@@ Ruby
    require 'spec_helper'

    describe('apache', :type => :class) do
      let(:node) { 'agent-centos.localdomain' }

      describe 'when call without parameters on redhat' do
        let(:facts) { {:osfamily => 'RedHat'} }

        it { should contain_package('httpd').with_ensure('installed') }

        it {
          should contain_file('/etc/httpd/conf/httpd.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
          ).with_content(/^ServerName #{node}.*$/)
        }

        it {
          should contain_service('httpd').with(
            'ensure' => 'running',
            'enable' => 'true',
          ).without(
            'status' => /.*/,
          )
        }

      end
    end

~~~ENDSECTION~~~


!SLIDE small
# Global Installation

Install `rspec-puppet`:

    @@@ Sh
    # gem install rspec-puppet

Install `puppetlabs_spec_helpers` to setup tests:

    @@@ Sh
    # gem install puppetlabs_spec_helper


!SLIDE small
# Module Configuration (1/2)

Create a module using the module tool:

    @@@ Sh
    # puppet module generate {username}-{modulename}

Create Rakefile:

    @@@ Sh
    # require 'puppetlabs_spec_helper/rake_tasks'

Update `spec/spec_helper.rb`:

    @@@ Sh
    # require 'puppetlabs_spec_helper/module_spec_helper'


!SLIDE smbullets
# Module Configuration (2/2)

Create `.fixtures.yml`:
 
* `rspec_puppet` compiles catalogs in a sandbox
* It needs a minimal environment, including modulepath
* It has to have entries for all module dependencies

    <pre>
    ---
    fixtures:
      symlinks:
        "apache": "#{source_dir}"
    </pre>


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

* Objective
 * Practice setting up a testing environment
 * Update the apache module and create unit tests for it
 * Practice incremental development using tests as validation
* Steps:
 * Install `puppet-rspec` and `puppetlabs_spec_helper`
 * Create `Rakefile`, `.fixtures.yml` and `spec_helper.rb`
 * Write unit tests in `spec/classes/apache_spec.rb`
 * Run unit tests and fix problems if appeared


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

## Objective:

* Practice setting up a testing environment
* Update the apache module and create unit tests for it
* Practice incremental development using tests as validation

## Steps:

* Install `puppet-rspec` and `puppetlabs_spec_helper`
* Create `Rakefile`, `.fixtures.yml` and `spec_helper.rb`
* Write unit tests in `spec/classes/apache_spec.rb`
* Run unit tests and fix problems if appeared


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Unit Test a Class

****

Install `puppet-rspec` and `puppetlabs_spec_helper`:

    @@@ Sh
    # gem install puppet-rspec
    # gem install puppetlabs_spec_helper

Create `Rakefile`, `.fixtures.yml` and `spec_helper.rb`:

    @@@ Sh
    # cd /etc/puppet/modules/
    # vim Rakefile
    require 'puppetlabs_spec_helper/rake_tasks'

    # mkdir -p spec/classes
    # vim spec/spec_helper.rb
    require 'puppetlabs_spec_helper/module_spec_helper'

    # vim .fixtures.yml
    ---
    fixtures:
      symlinks:
        "apache": "#{source_dir}"


Write unit tests in `spec/classes/apache_spec.rb`:

    # vim spec/classes/apache_spec.rb
    require 'spec_helper'

    describe('apache', :type => :class) do

      describe 'when call on an unsupportred operatingsystem' do
        let(:facts) { {:osfamily => 'foo'} }
        it do
          expect {
            should contain_package('httpd')
          }.to raise_error(Puppet::Error, /Your plattform is not supported, yet./)
        end
      end

      describe 'when call without parameters on redhat' do
        let(:facts) { {:osfamily => 'RedHat'} }
        it do
          should contain_package('httpd').with(
            'ensure' => 'installed')

          should contain_file('/etc/httpd/conf/httpd.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root').with_content(
              /^DocumentRoot \/var\/www\/html$/)

          should contain_service('httpd').with(
            'ensure' => 'running',
            'enable' => 'true')
        end
      end

      describe 'when call with ssl => true on redhat' do
        let(:facts) { {:osfamily => 'RedHat'} }
        it { should contain_package('mod_ssl') }
      end

    end

Run unit tests and fix problems if appeared:
