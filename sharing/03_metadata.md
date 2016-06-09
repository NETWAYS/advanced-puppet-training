!SLIDE small
# Metadata File

    @@@ Vim
    # cat /etc/puppet/modules/mysql/metadata.json
    {
      "name": "puppetlabs-mysql",
      "version": "3.1.0",
      "author": "Puppet Labs",
      ...
      "dependencies": [
        {"name":"puppetlabs/stdlib","version_requirement":">= 3.2.0"},
        {"name":"nanliu/staging","version_requirement":"1.x"}
      ]
    }

* Names and dependencies must be namespaced with author name
* Dependencies can be specified on:
 * Specific versions (1.2.3)
 * Logical greater/less than (>1.2.3, <=1.2.3, etc)
 * Ranges of versions (>=1.0.0 <2.0.0)
 * Semantic major versions (1.x) or minor versions (1.2.x)
