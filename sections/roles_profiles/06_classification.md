!SLIDE small
# Classifying Nodes

Simply assign a role to each node in the site manifest `site.pp`:

    @@@Puppet
    node 'agent-centos.localdomain' {
      include role::database_control_panel
    }

    node default {
    ...
    }


* Assign classes
* Configure classes with parameters and variables
* Convert arbitrary data from other sources into class parameters or variables
* Declare lone resources, outside any class


!SLIDE small
# External Node Classifier

* Called by the Puppet Master
* ENCs can co-exist with standard node definitions in `site.pp`
* Examples:
 * The Foreman
 * Puppet Enterprise Console
* Connecting an ENC:

<pre>
[master]
  node_terminus = exec
  external_nodes = /usr/local/bin/puppet_node_classifier
</pre>

!SLIDE small
#ENC YAML Output in YAML format

<pre>
---
parameters:
  hostgroup: OpenSCAP
  foreman_subnets:
  - name: foreman
    network: 192.168.56.0
    mask: 255.255.255.0
    gateway: 192.168.56.1
    dns_primary: 192.168.56.2
    boot_mode: DHCP
    ipam: DHCP
    mtu: 1500
    network_type: IPv4
classes:
  foreman_scap_client:
    policies:
    - id: 2
      profile_id: xccdf_org.ssgproject.content_profile_standard_customized
      minute: '0'
      hour: '1'
      monthday: "*"
      month: "*"
      weekday: '0'
    - id: 1
      profile_id: xccdf_org.ssgproject.content_profile_common
    port: 8443
    server: foreman.localdomain
environment: production
</pre>


!SLIDE small
# Assigning Classes with Hiera

* `hiera_include` function: **hiera_include('classes')**

Usage with YAML files:

<pre>
---
classes:
  - ntp

---
classes:
  - apache
  - postfix

# puppet apply -e "notice(hiera('classes'))"
["ntp", "apache", "postfix"]
</pre>
