!SLIDE noprint
# Configuration of a puppet device

The device needs to get configured on the puppet agent acting as proxy. A `device.conf` could look like this: 

    @@@Sh
    [cisco.example.com]
    type cisco_ios
    url file:///etc/puppetlabs/puppet/devices/cisco.example.com.yaml

The `device.conf` needs to be created in `/etc/puppetlabs/puppet/`

More Information on `device.conf`: https://puppet.com/docs/puppet/latest/config_file_device.html


!SLIDE noprint
# Classify the proxy puppet agent

Some device modules require the proxy Puppet agent to be classified with the base class of the device module to install or configure resources required by the module. Refer to the specific device module README for details.

    @@@Sh
    node 'agent.example.com' {
      include cisco_ios
    }


!SLIDE noprint
# Classify the device

In the site.pp manifest, declare DNS resources for the devices. For example:


    @@@Sh
    node 'cisco.example.com' {
     network_dns { 'default':
      servers => [4.2.2.2', '8.8.8.8'],
      search => ['localhost",'example.com'],
     }
    }

Apply the manifest by running `puppet device -v` on the proxy Puppet agent.
