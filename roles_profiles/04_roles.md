!SLIDE small 
# Roles

    @@@ Puppet
    class role::webapp {
      include profile::base
      include profile::customapp
      include profile::test_tools
    }

* Defines a set of technology stacks (profiles) that make up a logical role
* Includes as many profiles as required to define itself
* Abstracts the business role from the implementation details
* Contains no logic at all
* Roles only implement profiles


!SLIDE smbullets noprint
# Mapping Nodes to Roles

**A node can only have one role!**

* If a node requires two roles, it has by definition become a new role
* A single role can be applied to many nodes, however

<center><img src="../_images/roles_profiles/legacy_classification.png" style="width:800px;height:204px;" alt="Legacy Classification"/></center>


!SLIDE smbullets printonly
# Mapping Nodes to Roles

**A node can only have one role!**

* If a node requires two roles, it has by definition become a new role
* A single role can be applied to many nodes, however

<center><img src="../_images/roles_profiles/legacy_classification.png" style="width:470px;height:120px;" alt="Legacy Classification"/></center>


!SLIDE smbullets noprint
# Mapping Nodes to Roles

**A node can only have one role!**

* If a node requires two roles, it has by definition become a new role
* A single role can be applied to many nodes, however

<center><img src="../_images/roles_profiles/role_classification.png" style="width:800px;height:116px;" alt="Role Classification"/></center>


!SLIDE smbullets printonly
# Mapping Nodes to Roles

**A node can only have one role!**

* If a node requires two roles, it has by definition become a new role
* A single role can be applied to many nodes, however

<center><img src="../_images/roles_profiles/role_classification.png" style="width:470px;height:68px;" alt="Role Classification"/></center>


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Roles

* Objective:
 * Create and use a `webserver` role 
* Steps:
 * Combine `database` and `webserver` profiles to a role
 * Test and apply your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Roles

## Objective:

****

* Create and use a `webserver` role

## Steps:

****

* Combine `database` and `webserver` profiles to a role
* Test and apply your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Designing Roles

****

    @@@ Sh
    # vim /etc/puppetlabs/code/modules/roles/manifests/webserver.pp
    class roles::webserver {
      include profiles::database
      include profiles::webserver
    }

    # puppet parser validate /etc/puppetlabs/code/modules/roles/manifests/webserver.pp
    # vim /etc/puppetlabs/code/modules/roles/examples/webserver.pp
    include roles::webserver

    # puppet parser validate /etc/puppetlabs/code/modules/roles/examples/webserver.pp
    # puppet apply --noop /etc/puppetlabs/code/modules/roles/examples/webserver.pp
    # puppet apply /etc/puppetlabs/code/modules/roles/examples/webserver.pp
