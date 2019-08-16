!SLIDE noprint
# Why puppet over Powershell DSC?

Puppet compliments Powershell DSC and puppet supports dsc, with there very own modules `dsc` and `dsc_lite`. Puppet, similairly to Microsoft, deems declarative language modelling to be highly advantageous, because its repeatable and consumable.

To gain a little insight on the possibilities of puppet on windows, check out the supported windows modules: https://forge.puppet.com/modules?endorsements=partner+supported&os=windows

!SLIDE noprint
# dsc & dsc_lite

* Installing a module is no different on windows, so do either of these:
  * `puppet module install puppetlabs-dsc_lite`
  * `puppet module install puppetlabs-dsc`

!SLIDE noprint

# dsc modules approach

So dsc in powershell might look like this:


    @@@Sh
    WindowsFeature IIS {
      Ensure = 'present'
      Name   = 'Web-Server'
    }


The `puppetlabs/dsc` module could look like this:


    @@@sh
    dsc_windowsfeature {'IIS':
      dsc_ensure => 'present',
      dsc_name   => 'Web-Server',
    }


It's recommended to start of with the `puppetlabs/dsc` module, because its considered easier then the `puppetlabs/dsc_lite` module.


!SLIDE noprint
# dsc_lite modules approach

Use the example from the previous slide, lets see what the `puppetlabs/dsc_lite` approach could be: 


    @@@sh
    dsc {'iis':
      resource_name => 'WindowsFeature',
      module        => 'PSDesiredStateConfiguration',
      properties    => {
        ensure => 'present',
        name   => 'Web-Server',
      }
    }

Even though `puppetlabs/dsc_lite` is considered to be harder then `puppetlabs/dsc`, there is a point to be made, that in some peoples eyes it can be easier. It's just a more flexible approach, which an experienced user can take advantage of.
