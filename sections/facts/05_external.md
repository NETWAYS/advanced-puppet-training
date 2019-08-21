!SLIDE small
# External Facts

    @@@Sh
    $ cat {MODULE NAME}/facts.d/datacenter.yaml
    ---
    location: nuremberg
    cluster: webserver

    $ cat {MODULE NAME}/facts.d/datacenter.txt
    location=nuremberg
    cluster=webserver

    $ cat {MODULE NAME}/facts.d/datacenter.py
    #!/usr/bin/env python
    data = {"location" : "nuremberg", "cluster" : "webserver" }

    for k in data:
    print "%s=%s" % (k,data[k])


    $ facter location
    nuremberg

* Could be YAML, JSON, text files or executable scripts
* Also distributed via pluginsync from {MODULE NAME}/facts.d

~~~SECTION:handouts~~~

****

As of Puppet 3.4 and Facter 2.0.1, external facts are now pluginsynced like any other custom fact. This makes distributing these facts much simpler. External facts should be located in the module's facts.d directory, and they'll automatically synced on each Puppet run.

External facts will also execute scripts in the external fact path with the execute bit set. For Facter to parse the output, the script must echo key/value pairs on stdout in the format: key1=value1 key2=value2

~~~ENDSECTION~~~
