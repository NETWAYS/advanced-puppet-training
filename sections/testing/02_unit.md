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

    @@@Ruby
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

    @@@Sh
    $ /opt/puppetlabs/puppet/bin/rake spec \
    /opt/puppetlabs/puppet/bin/ruby \
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

    @@@Sh
    it {should compile}

Validate the catolog contains resources:

    @@@Sh
    contain_{resource type}

Validate that resources have specified attributes:

    @@@Sh
    with_{attribute}
    without_{attribute}

Validate that resources have relationships set:

    @@@Sh
    that_{relationship}

Shortcut helpers combine matchers:

    @@@Sh
    with, without

~~~SECTION:handouts~~~

****

RSpec matchers can match exact values, regular expressions, or Ruby Procs. You can see example usages for many matchers in the code sample on the following page.

    @@@Ruby
    require 'spec_helper'

    describe('apache', :type => :class) do
      let(:node) { 'agent-centos.localdomain' }

      describe 'when call without parameters on redhat' do
        let(:facts) { {:osfamily => 'RedHat'} }

        it { should contain_package('httpd').with_ensure('installed') }

~~~PAGEBREAK~~~

    @@@ Ruby
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

    @@@Sh
    $ gem install rspec-puppet

Install `puppetlabs_spec_helpers` to setup tests:

    @@@Sh
    $ gem install puppetlabs_spec_helper


!SLIDE small
# Module Configuration (1/2)

Create a module using the module tool:

    @@@Sh
    $ puppet module generate {username}-{modulename}

Create Rakefile:

    @@@Sh
    $ require 'puppetlabs_spec_helper/rake_tasks'

Update `spec/spec_helper.rb`:

    @@@Sh
    $ require 'puppetlabs_spec_helper/module_spec_helper'


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
 * Install `rspec-puppet` and `puppetlabs_spec_helper` on `agent-centos.localdomain`
 * Create `Rakefile`, `.fixtures.yml` and `spec_helper.rb`
 * Write unit tests in `spec/classes/apache_spec.rb`
 * Run unit test


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

## Objective:

****

* Practice setting up a testing environment
* Update the apache module and create unit tests for it
* Practice incremental development using tests as validation

## Steps:

****

* Install `rspec-puppet` and `puppetlabs_spec_helper` on `agent-centos.localdomain`
* Create `Rakefile`, `.fixtures.yml` and `spec_helper.rb`
* Write unit tests in `spec/classes/apache_spec.rb`
* Run unit test


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Unit Test a Class

****

Install `rspec-puppet` and `puppetlabs_spec_helper` on `agent-centos.localdomain`:

    @@@Sh
    training@agent $ sudo /opt/puppetlabs/puppet/bin/gem install rspec-puppet
    training@agent $ sudo /opt/puppetlabs/puppet/bin/gem install puppetlabs_spec_helper

Create `Rakefile`, `.fixtures.yml` and `spec_helper.rb`:

    @@@Sh
    training@agent $ cd /home/training/puppet/modules/apache
    training@agent $ vim Rakefile
    require 'puppetlabs_spec_helper/rake_tasks'

    training@agent $ mkdir -p spec/classes
    training@agent $ vim spec/spec_helper.rb
    require 'puppetlabs_spec_helper/module_spec_helper'

    training@agent $ vim .fixtures.yml
    ---
    fixtures:
      symlinks:
        "apache": "#{source_dir}"

~~~PAGEBREAK~~~

Write unit tests in `spec/classes/apache_spec.rb`:

    training@agent $ mkdir spec/classes
    training@agent $ vim spec/classes/apache_spec.rb
    require 'spec_helper'

    describe('apache', :type => :class) do

      describe 'when call on an unsupported operatingsystem' do
        let(:facts) { {:osfamily => 'foo'} }
        it do
          expect {
            should contain_package('httpd')
          }.to raise_error(Puppet::Error, /Your platform is not supported, yet./)
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
          'group'  => 'root')
        
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

Run unit test:

    training@agent $ cd /home/training/puppet/modules/apache/
    training@agent $ /opt/puppetlabs/puppet/bin/rake spec -- \
    /opt/puppetlabs/puppet/bin/ruby -S \
    spec/classes/apache_spec.rb --color
