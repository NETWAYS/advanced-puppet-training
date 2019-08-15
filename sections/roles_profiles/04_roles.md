!SLIDE smbullets small 
# Roles

    @@@Puppet
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
* However, a single role can be applied to many nodes

<center><img src="./_images/role_classification.png" style="width:800px;height:116px;" alt="Role Classification"/></center>


!SLIDE smbullets printonly
# Mapping Nodes to Roles

**A node can only have one role!**

* If a node requires two roles, it has by definition become a new role
* A single role can be applied to many nodes, however

<center><img src="./_images/role_classification.png" style="width:434px;height:63px;" alt="Role Classification"/></center>


!SLIDE smbullets 
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Roles

* Objective:
 * Create and use a `webserver` role on `agent-centos.localdomain`
* Steps:
 * Combine `database` and `webserver` profiles to a role
 * Test and apply your configuration


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Designing Roles

## Objective:

****

* Create and use a `webserver` role on `agent-centos.localdomain`

## Steps:

****

* Combine `database` and `webserver` profiles to a role
* Test and apply your configuration


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Designing Roles

****

Create and use a `webserver` role on `agent-centos.localdomain`:

    @@@Sh
    training@agent $ mkdir /home/training/puppet/modules/role/{examples,manifests}
    training@agent $ cd /home/training/puppet/modules

Combine `database` and `webserver` profiles to a role:

    @@@Sh
    training@agent $ vim role/manifests/webserver.pp
    class role::webserver {
      include profile::database
      include profile::webserver
    }

    training@agent $ puppet parser validate role/manifests/webserver.pp
    training@agent $ vim role/examples/webserver.pp
    include role::webserver

    training@puppet $ puppet parser validate role/examples/webserver.pp

Test and apply your configuration:

    @@@Sh
    training@agent $ sudo puppet apply --noop role/examples/webserver.pp
    training@agent $ sudo puppet apply role/examples/webserver.pp
