!SLIDE smbullets
# Git Hooks

* Assist Puppet module development
* Client side hooks allow for various checks before commits are staged (`pre-commit`, `prepare-commit-msg`, `post-commit`, etc.)
* Server side hooks are provided for infrastructural reinforcement of various standardization compliances (`pre-receive`, `update` and `post-receive`)

~~~SECTION:handouts~~~

****

Puppet Git Hooks are available from: https://github.com/drwahl/puppet-git-hooks

~~~PAGEBREAK~~~

Client side checks:

* Puppet manifest syntax
* Puppet epp template syntax
* Erb template syntax
* Puppet-lint
* Rspec-puppet
* Yaml (hiera data) syntax
* r10k puppetfile syntax

Server side checks:

* Puppet manifest syntax
* Puppet epp template syntax
* Erb template syntax
* Ruby syntax
* Puppet-lint
* Yaml (hiera data) syntax

~~~ENDSECTION~~~
