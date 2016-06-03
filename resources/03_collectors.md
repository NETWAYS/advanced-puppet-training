!SLIDE smbullets small
# Resource Collectors

    @@@ Puppet
    Type <| [Attribute] [Search Expression] [Search Key] |>

* Select a group of resources by searching the attributes of every resource in the catalog
* Collectors realize virtual resources

Realize all virtual user resources:

    @@@ Puppet
    User <| |>

Realize all system administrators:

    @@@ Puppet
    User <| groups == 'sysadmin' |>

Realize all users tagged with Portland:

    @@@ Puppet
    User <| tag == 'nuremberg' |>


!SLIDE smbullets
# Search Expressions

* **==** (equality search)<br/>
Match if the value of the attribute is identical to the search key
* **!=** (non-equality search)<br/>
Match if the value of the attribute is not identical to the search key
* **and**<br/>
Both operands must be search expressions that evaluate as true
* **or**<br/>
Either operand can be a search expression that evaluates as true


!SLIDE small
# Realizing with Collectors

    @@@ Puppet
    @user { 'luke': ensure => present, }

    @user { 'james':
      ensure => present,
      groups  => 'dba',
    }

    @user { 'jeff':
      ensure => present,
      groups  => 'sysadmin',
    }

    @user { 'brad':
      ensure => present,
      groups  => 'webadmins',
    }

    User <| (groups == 'dba' or groups == 'sysadmin') or title

The users luke, james, jeff will be created, but brad will not.
