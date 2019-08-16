!SLIDE noprint
# Chocolatey

Chocolatey is like apt-get, but for Windows.

* There are two chocolatey modules:
  * `puppetlabs/chocolatey`, which is recommended.
  * `chocolatey/chocolatey`, which which keeps up with all the new features, but is not as fully tested.

If a `chocolatey` module is installed, it will be used as `default` provider by the package resource.

!SLIDE noprint
# Chocolatey vs Built-in Provider

The chocolatey module makes life a lot easier, because using the built-in provider can be annoying.

Here an example of installing git, via the built-in provider:

    @@@Sh
    package { "Git version 1.8.4-preview20130916":
      ensure    => installed,
      source    => 'C:\temp\Git-1.8.4-preview20130916.exe',
      install_options => ['/VERYSILENT']
    }

Chocolateys approach is just like it would be on a \*nix system. In this example chocolatey is set as default provider:
    
    package { 'git':
      ensure   => latest,
    }
    
