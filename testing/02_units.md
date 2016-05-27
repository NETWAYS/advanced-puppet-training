!SLIDE smbullets small
# Unit Tests

****

What Should You be Testing?

****

* Unit tests do not test the result on a live system.
* Test the behaviour of Puppet catalog compilations to:
 * Ensure that resources are included.
 * Ensure that classes are declared.
 * Validate resource attributes.
 * Evaluate with different class parameters.


!SLIDE smbullets small
# Unit Tests

****

rspec-puppet

****

RSpec tests for Puppet manifests:

<pre>
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
</pre>

Running tests:

<pre>
# /opt/puppetlabs/puppet/bin/rake spec
/opt/puppetlabs/puppet/bin/ruby -S rspec spec/classes/motd_spec.rb --color
...
Finished in 0.14713 seconds 1 example, 0 failures
</pre>

~~~SECTION:handouts~~~

****

To get a quick overview of the http://puppet.com/tutorial/. This will teach you how to write simple unit tests for your modules and might be all you ever need to read.

Remember that you do not need to run rspec-puppet-init when using puppetlabs_spec_helper.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Unit Tests

****

RSpec Matchers

****

* Validate successful catalog compilation:
<pre>
it { should compile }
</pre>

* Validate the catolog contains resources:
<pre>
contain_< resource type >
</pre>

* Validate that resources have specified attributes:
<pre>
with_< attribute >
without_< attribute >
</pre>

* Validate thate resources have relationships set:
<pre>
that_< relationship >
</pre>

* Shortcut helpers combine matchers:
<pre>
with, without
</pre>

~~~SECTION:handouts~~~

****

RSpec matchers can match exact values, regular expressions, or Ruby Procs. You can see example usages for many matchers in the code sample on the following page.

<pre>
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


!SLIDE smbullets small
# Unit Tests

****

Global Installation:

****

* Install rspec-puppet.
<pre>
/opt/puppetlabs/puppet/bin/gem install rspec-puppet
</pre>
* Install puppetlabs_spec_helpers to setup tests.
<pre>
/opt/puppetlabs/puppet/bin/gem install puppetlabs_spec_helper
</pre>


!SLIDE smbullets small
# Unit Tests

****

Module Configuration

****

* Create a module using the module tool.
<pre>
puppet module generate < username >-< modulename >
</pre>
* Create Rakefile.
<pre>
require 'puppetlabs_spec_helper/rake_tasks'
</pre>
* Update spec/spec_helper.rb.
<pre>
require 'puppetlabs_spec_helper/module_spec_helper'
</pre>
* Create .fixtures.yml.
 * rspec_puppet compiles catalogs in a sandbox.
 * It needs a minimal environment, including modulepath.
 * It has to have entries for all module dependencies.

</pre>
---
fixtures:
  symlinks:
    "apache": "#{source_dir}"
</pre>


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

* Objective
 * Update the apache module and create unit tests for it.
 * Practice setting up a testing environment.
 * Practice incremental development using tests as validation.


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Unit Test a Class

## Objective:

 * Update the apache module and create unit tests for it.
 * Practice setting up a testing environment.
 * Practice incremental development using tests as validation.

## Steps:

fvkjge
