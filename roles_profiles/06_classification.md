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
