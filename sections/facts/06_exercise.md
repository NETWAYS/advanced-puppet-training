!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Fact

* Objective:
 * Expand your apache module to provide a fact for the apache version
* Steps:
 * Create the fact in `lib/facter/apache_version.rb`
 * Test the new fact locally


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Fact

## Objective:

****

* Expand your apache module to provide a fact for the apache version.

## Steps:

****

* Create the fact in `lib/facter/apache_version.rb`:
 * Use a command line with apachectl and sed
 * optional: Build the same fact in ruby

'apachectl -v 2>&1|sed -n "s|^Server version:\s*Apache/\([0-9]\\+.[0-9]\\+.[0-9]\\+\).*$|\1|p"'

* Test the new fact locally


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Fact

****

## Expand your apache module to provide a fact for the apache version

****

### Use a command line with apachectl and sed

Create the subdirectory structure for custom facts:

    @@@ Sh
    training@puppet $ mkdir -p /home/training/puppet/modules/apache/lib/facter

Create a new ruby file `/home/training/puppet/modules/apache/lib/facter/apache_version.rb`:

    @@@SH
    training@puppet $ cd /home/training/puppet/modules
    training@puppet $ vim apache/lib/facter/apache_version.rb
    Facter.add(:apache_version) do
      setcode 'apachectl -v 2>&1 | \
        sed -n "s|^Server version:\s*Apache/\([0-9]\\+.[0-9]\\+.[0-9]\\+\).*$|\1|p"'
    end

### Test your code locally

Check the syntax of the ruby file:

    @@@Sh
    training@puppet $ ruby -c ./apache/lib/facter/apache_version.rb
    Syntax OK

Call facter by setting the RUBYLIB environment variable:

    @@@Sh
    training@puppet $ RUBYLIB=/home/training/puppet/modules/apache/lib facter apache_version
    2.4.6

### Optional: Build the same fact in ruby

New content of `/home/training/puppet/modules/apache/lib/facter/apache_version.rb`:

    @@@Sh
    training@puppet $ cd /home/training/puppet/modules
    training@puppet $ vim apache/lib/facter/apache_version.rb
    Facter.add(:apache_version) do
      setcode do
        if Facter::Util::Resolution.which('apachectl')
          apache_version = Facter::Util::Resolution.exec('apachectl -v 2>&1')
          %r{^Server version: Apache\/([\w\.]+) \(([\w ]*)\)}.match(apache_version)[1]
        end
      end
    end
