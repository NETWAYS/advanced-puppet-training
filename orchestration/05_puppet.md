!SLIDE smbullets
# MCollective Puppet Applications

* `puppet`
 * Manages the on-demand running of your Puppet Agents
* `package`
 * Uses Puppet RAL to manage package state
* `service`
 * Uses Puppet RAL to manage service state


!SLIDE smbullets
# puppet Application Usage

* Run Puppet on 5 Debian nodes at a time:

    <pre>
    # mco puppet runall -F osfamily=Debian 5
    </pre>

* Temporarily disable Puppet on `dev` classified nodes:

    <pre>
    # mco puppet disable -C dev
    </pre>

* Retrieve the last run summary from a node:

    <pre>
    # mco puppet summary -I proxy.training.vm
    </pre>


!SLIDE smbullets
# package Application Usage

* Install a package on classified nodes:

    <pre>
    # mco package install httpd -C backend
    </pre>

* Update a package on a named node:

    <pre>
    # mco package update httpd -I bob.training.vm
    </pre>

* Retrieve package versions from all RedHat machines:

    <pre>
    # mco package status httpd -F osfamily=RedHat
    </pre>


!SLIDE smbullets
# service Application Usage

* Restart a service on all `travis` classified nodes:

    <pre>
    # mco service travis-ci restart -C travis
    </pre>

* Stop a service on a named node:

    <pre>
    # mco service exim stop -I compromised.training.vm
    </pre>

* Discover how many mailservers are running:

    <pre>
    # mco service exim status
    </pre>
