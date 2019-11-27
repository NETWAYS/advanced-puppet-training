!SLIDE noprint
# Exec resource on Windows

Puppet uses the same exec resource type on both \*nix and Windows systems, and there are a few Windows-specific best practices and tips to keep in mind. 

Puppet can run binary files (such as `exe`, `com`, or `bat`), and can log the child process output and exit status. To ensure the resource is idempotent, specify one of the creates, onlyif, or unless attributes.

Puppet does not support a shell provider for Windows, so if you want to execute shell built-ins (such as `echo`), you must provide a complete `cmd.exe` invocation as the command. For example, `command => 'cmd.exe /c echo "hello"'`.

When using `cmd.exe` and specifying a file path in the command line, be sure to use backslashes. For example, `'cmd.exe /c type c:\path\to\file.txt'`. If you use forward slashes, `cmd.exe` returns an error.

Recommended alternative is the `puppetlabs/powershell` module.

!SLIDE noprint
# Modules for Resources on Windows

Obviously, many modules and commands are tailored to \*.nix systems, yet puppet has some rather interesting modulepacks that are quite helpful. One of them is puppetlabs-windows: https://forge.puppet.com/puppetlabs/windows/readme

* [puppetlabs/acl](https://forge.puppet.com/puppetlabs/acl "puppetlabs/acl"): A resource type for managing access control lists (ACLs) on Windows.
* [puppetlabs/registry](https://forge.puppet.com/puppetlabs/registry "puppetlabs/registry"): A resource type for managing arbitrary registry keys.
* [puppetlabs/reboot](https://forge.puppet.com/puppetlabs/reboot "puppetlabs/reboot"): A resource type for managing conditional reboots, which can be necessary for installing certain software.
* [puppetlabs/dism](https://forge.puppet.com/puppetlabs/dism "puppetlabs/dism"): A resource type for enabling and disabling Windows features (on Windows 7 or 2008 R2 and newer).
* [puppetlabs/powershell](https://forge.puppet.com/puppetlabs/acl "puppetlabs/dism"): An alternative exec provider that can directly execute PowerShell commands.

To gain a little insight on the possibilities of puppet on windows, check out the supported windows modules: https://forge.puppet.com/modules?endorsements=partner+supported&os=windows
