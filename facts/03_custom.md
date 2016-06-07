!SLIDE small
# Custom Facts

    @@@ Ruby
    # role.rb
    Facter.add('role') do
      setcode do
        role = Facter::Core::Execution.exec('cat /etc/role')
        role.gsub(/<.*?>/m, "")
      end
    end

* The fact is set to the string value returned from setcode block
* With facter 2.0 or higher array and hash also permitted as return value

If on a string no other manipulation is needed you can pass the string to `setcode`:

    @@@ Ruby
    # role.rb
    Facter.add('role') do
      setcode 'cat /etc/role'
    end

~~~SECTION:handouts~~~

****

`setcode` will accept a Ruby block or a single shell command as a string. For example, you could implement first fact concisely in pure Ruby like so:

    @@@ Ruby
    # role.rb
    Facter.add('role') do
      setcode do
        File.read('/etc/role').gsub(/<.*?>/m, "")
      end
    end

Note that older versions of Facter exposed a method called `Facter::Util::Resultion.exec`. This has been deprecated and currently redirects to the method `Facter::Core::Execution.exec` you see in the example.

~~~ENDSECTION~~~
