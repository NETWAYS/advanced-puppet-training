!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Fact

* Objective:
 * Expand your apache module to provide a fact for the apache version
* Steps:
 * Create the fact in `lib/facter/apache_version.rb`
 * Test the new fact locally
 * Push your code to the master, do an agent run and call facter


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
* Push your code to the master, do an agent run and call facter


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Create a Custom Fact

****

## Expand your apache module to provide a fact for the apache version

****

### Use a command line with apachectl and sed

Change into your apache directory:

    @@@ Sh
    # cd ~/puppetcode/modules

Create the subdirectory structure for custom facts:

    @@@ Sh
    # mkdir -p ./apache/lib/facter

Create a new ruby file `./apache/lib/facter/apache_version.rb`:

    @@@ Ruby
    Facter.add(:apache_version) do
      setcode 'apachectl -v 2>&1 | \
        sed -n "s|^Server version:\s*Apache/\([0-9]\\+.[0-9]\\+.[0-9]\\+\).*$|\1|p"
    end

### Test your code locally

Change into your module directory:

    @@@ Sh
    # cd ~/puppetcode/modules

Check the syntax of the ruby file:

    @@@ Sh
    # ruby -c ./apache/lib/facter/apache_version.rb
    Syntax OK

Call facter by setting the RUBYLIB environment variable:

    @@@ Sh
    # RUBYLIB=$PWD/apache/lib facter apache_version
    2.4.6

### Optional: Build the same fact in ruby

New content of `./apache/lib/facter/apache_version.rb`:

    @@@ Ruby
    Facter.add(:apache_version) do
      setcode do
        if Facter::Util::Resolution.which('apachectl')
          apache_version = Facter::Util::Resolution.exec('apachectl -v 2>&1')
          %r{^Server version: Apache\/([\w\.]+) \(([\w ]*)\)}.match(apache_version)[1]
        end
      end
    end
